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
        
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: topAnchor),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.bottomAnchor.constraint(equalTo: bottomAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
        ])
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

        return cell
    }
}

extension ServicesView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        print(indexPath)
//        print(servicesData[indexPath.row].link)
//        UIApplication.shared.open()
        delegate?.openBrowser(for: URL(string: servicesData[indexPath.row].link)!)
//        print(UIApplication.shared.canOpenURL(URL(string: "citydrive://citydrive.ru")!))
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
