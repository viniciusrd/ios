//
//  PasswordsViewController.swift
//  SuperSenha
//
//  Created by Vinicius Rodrigues on 28/02/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class PasswordsViewController: UIViewController {
    @IBOutlet weak var tvPasswords: UITextView!
    
    var numberOfCharacters: Int = 10;
    var numberOfPasswords: Int = 1;
    var useLetters: Bool!;
    var useNumbers: Bool!;
    var useCapitalLetters: Bool!;
    var useSpecialCharacters: Bool!;
    
    @IBOutlet weak var btnGenerateAgain: UIButton!
    var passwordGenerator : PasswordGenerator!;
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Total de senhas: \(numberOfPasswords)";
        self.btnGenerateAgain.layer.cornerRadius = 5
        self.btnGenerateAgain.layer.borderWidth = 1
        
        
        passwordGenerator = PasswordGenerator(numberOfCharacters: numberOfCharacters, numberOfPasswords: numberOfPasswords, useLetters: useLetters, useNumbers: useNumbers, useCapitalLetters: useCapitalLetters, useSpecialCharacters: useSpecialCharacters)
        
        self.generatePassword();
        
    }
    
    func generatePassword()  {
        //manipulando o scrool
        tvPasswords.scrollRangeToVisible(NSRange(location: 0, length: 0))
        tvPasswords.text = "";
        let passwords = passwordGenerator.generate(total: numberOfPasswords)
        for password in passwords {
            tvPasswords.text.append(password+"\n\n");
        }
    }
    
    @IBAction func generatePassword(_ sender: UIButton) {
        self.generatePassword();
    }
    
}
