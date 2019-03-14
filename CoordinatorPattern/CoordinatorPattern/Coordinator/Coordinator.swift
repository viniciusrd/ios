//
//  Coordinator.swift
//  CoordinatorPattern
//
//  Created by Vinicius Rodrigues on 12/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
import UIKit
protocol Coordinator {
    var childCoordinators: [Coordinator] {get set}
    var navigationController: UINavigationController { get set }
    func start();
}
