//
//  ViewController+Extensions.swift
//  ServicesApp
//
//  Created by Евгений Беляков on 31.03.2024.
//

import UIKit

fileprivate var containerView: UIView?

extension UIViewController{
    func showLoadingView() {
        containerView = UIView(frame: view.bounds)
        view.addSubview(containerView!)
        
        containerView!.backgroundColor = .lightGray
        containerView!.alpha = 0
        
        UIView.animate(withDuration: 0.25){
            containerView!.alpha = 0.8
        }
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        containerView?.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: containerView!.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: containerView!.centerYAnchor),
        ])
        
        activityIndicator.startAnimating()
    }
    
    func dismissLoadingView() {
        if containerView != nil {
            containerView!.removeFromSuperview()
            containerView = nil
        }
    }
}

