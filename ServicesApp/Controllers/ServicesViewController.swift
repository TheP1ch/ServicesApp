//
//  ViewController.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 29.03.2024.
//

import UIKit
import SafariServices

protocol ServicesDelegate: AnyObject {
    func reloadData() -> ()
    
    func openBrowser(for: URL) -> ()
}

class ServicesViewController: UIViewController {
    
    private lazy var primaryView: ServicesView = {
        let view = ServicesView()
        view.translatesAutoresizingMaskIntoConstraints = false
        view.delegate = self
        
        return view
    }()
    
    private let apiManager: ApiManager
    
    init(apiManager: ApiManager) {
        self.apiManager = apiManager
        
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Сервисы"
        view.backgroundColor = .systemBackground
        configurePrimaryView()
    }
    
    private func configurePrimaryView() {
        view.addSubview(primaryView)
        
        NSLayoutConstraint.activate([
            primaryView.topAnchor.constraint(equalTo: view.topAnchor),
            primaryView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            primaryView.leadingAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leadingAnchor),
            primaryView.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
        ])
    }
    
    
}

extension ServicesViewController: ServicesDelegate{
    func reloadData() {
        
    }
    
    func openBrowser(for citeUrl: URL) {
        present(SFSafariViewController(url: citeUrl), animated: true)
    }
    
}
