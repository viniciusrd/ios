//
//  ViewController.swift
//  SuperSenha
//
//  Created by Vinicius Rodrigues on 28/02/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var tfTotalPasswords: UITextField!
    @IBOutlet weak var tfNumberOfCharacters: UITextField!
    @IBOutlet weak var swLetters: UISwitch!
    @IBOutlet weak var swCapitalLetters: UISwitch!
    @IBOutlet weak var swNumbers: UISwitch!
    @IBOutlet weak var swSpecialCharacters: UISwitch!
    @IBOutlet weak var btnGeneratePassword: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        self.btnGeneratePassword.layer.cornerRadius = 5
        self.btnGeneratePassword.layer.borderWidth = 1
    }

    //Passando informacoes
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let passwordViewController = segue.destination as! PasswordsViewController;
        if let numberOfPasswords = Int(tfTotalPasswords.text!){
            passwordViewController.numberOfPasswords = numberOfPasswords;
        }
        if let numberOfCharacters = Int(tfNumberOfCharacters.text!){
            passwordViewController.numberOfCharacters = numberOfCharacters;
        }
        passwordViewController.useLetters = swLetters.isOn;
        passwordViewController.useNumbers = swNumbers.isOn;
        passwordViewController.useCapitalLetters = swCapitalLetters.isOn;
        passwordViewController.useSpecialCharacters = swSpecialCharacters.isOn;
        view.endEditing(true);
    }

}

