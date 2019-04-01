//
//  ApplicationCoordinator.swift
//  ModalExample
//
//  Created by Vinicius Rodrigues on 26/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
class ApplicationCoordinator: Coordinator {
    
    let window: UIWindow
    let rootViewController: UINavigationController
    let modalCoordinator: MainCoordinator
    
    init(window: UIWindow) {
        self.window = window
        self.rootViewController = UINavigationController()
        self.modalCoordinator = MainCoordinator(navigationController: rootViewController)
    }
    
    func start() {
        window.rootViewController = rootViewController
        modalCoordinator.start()
        window.makeKeyAndVisible()
    }
}
