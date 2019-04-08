//
//  MainCoordinator.swift
//  ModalExample
//
//  Created by Vinicius Rodrigues on 27/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit
class MainCoordinator: Coordinator {
    
    var childCoordinator:[Coordinator] = []
    var navigationController: UINavigationController
    var name: String = "MainCoordinator"
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        showMain()
    }
    
    internal func showMain(){
        let viewController = UIStoryboard(name: "Main", bundle: nil).instantiateInitialViewController() as! MainViewController
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
    
    internal func openModal(){
        let viewController = UIStoryboard(name: "ModalExample", bundle: nil).instantiateViewController(withIdentifier: "ModalExampleViewController") as! ModalExampleViewController
        viewController.modalPresentationStyle = .overCurrentContext
        viewController.delegate = self
        self.navigationController.pushViewController(viewController, animated: true)
    }
}

extension MainCoordinator: MainViewControllerDelegate{
    func didTapOpenModal() {
        self.openModal()
    }
}

extension MainCoordinator: ModalExampleViewControllerDelegate{
    func didTapConfirm(code: String?, on viewController: ModalExampleViewController) {
        
    }
    
    func didTapCancel(on viewController: ModalExampleViewController) {
        self.navigationController.popViewController(animated: true)
    }
}
