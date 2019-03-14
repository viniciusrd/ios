//
//  ApplicationCoordinator.swift
//  CoordinatorPattern
//
//  Created by Vinicius Rodrigues on 12/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
class ApplicationCoordinator: Coordinator {
    
    private let window: UIWindow
    private let rootViewController: UINavigationController
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController();
        rootViewController.navigationController?.navigationBar.prefersLargeTitles = true
        
        let emptyViewController = UIViewController()
        emptyViewController.view.backgroundColor = .cyan
        self.rootViewController.pushViewController(emptyViewController, animated: false)
    }
    
    //Implements protocol
    func start() {
        
    }
}

