//
//  ModalExampleViewController.swift
//  ModalExample
//
//  Created by Vinicius Rodrigues on 26/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

protocol ModalExampleViewControllerDelegate: class {
    func didTapConfirm(code: String?, on viewController: ModalExampleViewController)
    func didTapCancel(on viewController: ModalExampleViewController)
    
}

class ModalExampleViewController: UIViewController {

    @IBOutlet weak var background: UIView!
    @IBOutlet weak var lbTitle: UILabel!
    @IBOutlet weak var lbHelp: UILabel!
    @IBOutlet weak var lbAlert: UILabel!
    @IBOutlet weak var btnConfirm: UIButton!
    @IBOutlet weak var btnCancel: UIButton!
    @IBOutlet weak var load: UIActivityIndicatorView!
    @IBOutlet weak var textField: UITextField!
    
    var delegate: ModalExampleViewControllerDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupInitialUI()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupInitialUI() {
        
        lbAlert.isHidden = true
        load.hidesWhenStopped = true
    }
    
    @IBAction func didTapConfirm(_ sender: UIButton) {
        if let code = textField.text{
            self.delegate?.didTapConfirm(code: code, on: self)
        }
    }
    
    @IBAction func didTapCancel(_ sender: UIButton) {
        self.delegate?.didTapCancel(on: self)
    }
    
}
