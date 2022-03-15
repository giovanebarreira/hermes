//
//  UIViewController+Spinner.swift
//  GithubGraphQL
//
//  Created by Avanade on 15/03/22.
//  Copyright © 2022 test. All rights reserved.
//


import UIKit

fileprivate var aView: UIView?

extension UIViewController {
    
    func showSpinner() {
        aView = UIView(frame: self.view.bounds)
        aView!.backgroundColor = UIColor(red: 0.5, green: 0.5, blue: 0.5, alpha: 0.5)
        
        let activityIndicator = UIActivityIndicatorView(style: .large)
        activityIndicator.center = aView!.center
        activityIndicator.startAnimating()
        aView!.addSubview(activityIndicator)
        self.view.addSubview(aView!)
    }
    
    func removeSpinner() {
        if aView != nil {
            aView?.removeFromSuperview()
            aView = nil
        }
    }
}
