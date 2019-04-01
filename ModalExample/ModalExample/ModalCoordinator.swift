//
//  ModalCoordinator.swift
//  ModalExample
//
//  Created by Vinicius Rodrigues on 26/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//
import UIKit
class ModalCoordinator: Coordinator {
    
    var childCoordinators:[Coordinator] = []
    var navigationController: UINavigationController
    var storyboardIdentifier = "ModalExample"
    
    init(navigationController: UINavigationController) {
        self.navigationController = navigationController
    }
    
    func start() {
        self.navigationController.setNavigationBarHidden(true, animated: true)
        showFirstModalViewController()
    }
    
    internal func showFirstModalViewController()  {
        let viewController = UIStoryboard(name: storyboardIdentifier, bundle: nil).instantiateViewController(withIdentifier: "ModalExampleViewController") as! ModalExampleViewController
        viewController.modalPresentationStyle = .overFullScreen
        navigationController.present(viewController, animated: true, completion: nil)
    }
    
    
}
