//
//  ServicesView.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 29.03.2024.
//

import UIKit


class ServicesView: UIView {
    
    weak var delegate: ServicesDelegate?
    
    private var servicesData: [Service] = []
    
    private let tableView: UITableView = {
        let tableView = UITableView()
        tableView.translatesAutoresizingMaskIntoConstraints = false
        tableView.register(ServiceTableViewCell.self, forCellReuseIdentifier: ServiceTableViewCell.cellIdentifier)
        tableView.estimatedRowHeight = 60
        tableView.rowHeight = UITableView.automaticDimension
        
        return tableView
    }()
    
    private lazy var refreshControl: UIRefreshControl = {
        let refreshControl = UIRefreshControl(frame: .zero, primaryAction: refreshAction)
        refreshControl.tintColor = .gray
        
        return refreshControl
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        configureTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(servicesData: [Service]){

        self.servicesData = servicesData
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
    private func configureTableView() {
        addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.refreshControl = refreshControl
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
    }
    
    private lazy var refreshAction: UIAction = UIAction{ [weak self] _ in
        defer{
            self?.refreshControl.endRefreshing()
        }
        guard let self, let delegate = delegate else {return}
        
        delegate.reloadData()
        
    }
}

extension ServicesView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        servicesData.count
    }   
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: ServiceTableViewCell.cellIdentifier, for: indexPath) as? ServiceTableViewCell else{
            return UITableViewCell()
        }
        cell.configureCell(cellData: servicesData[indexPath.row])
        Task{ [weak self] in
            do{
                guard let self else {return}
                let imageUrl = self.servicesData[indexPath.row].iconUrl
                let image = try await self.delegate?.downloadImage(url: imageUrl)
                
                cell.uploadServiceImage(img: image ?? UIImage(named: "service.placeholder.image")!)
            } catch {
                print(error)
            }
        }
        
        return cell
    }
}

extension ServicesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        delegate?.openBrowser(for: URL(string: servicesData[indexPath.row].link)!)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
