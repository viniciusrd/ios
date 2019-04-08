//
//  ViewController.swift
//  ModalExample
//
//  Created by Vinicius Rodrigues on 26/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

protocol MainViewControllerDelegate: class {
    func didTapOpenModal()
}

class MainViewController: UIViewController {

    var delegate: MainViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    @IBAction func openModal(_ sender: UIButton) {
        self.delegate?.didTapOpenModal()
    }
    
}

