//
//  ViewController.swift
//  DelegateTextField
//
//  Created by Vinicius Rodrigues on 04/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITextFieldDelegate {
   
    @IBOutlet weak var tfEmail: UITextField!
    @IBOutlet weak var tfPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.tfEmail.delegate = self;
        self.tfPassword.delegate = self;
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        view.endEditing(true);
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == self.tfEmail{
            self.tfPassword.becomeFirstResponder();
        }else if textField == self.tfPassword{
            print("tirando teclado")
            self.tfPassword.resignFirstResponder();
        }
        return true
    }
}

