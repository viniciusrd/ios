//
//  SettingsViewController.swift
//  ComprasUSA
//
//  Created by Vinicius Rodrigues on 07/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class SettingsViewController: UIViewController {
    @IBOutlet weak var tfDolar: UITextField!
    @IBOutlet weak var tfIOF: UITextField!
    @IBOutlet weak var tfStateTaxes: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tfDolar.text = tc.gerFormmaterValue(of: tc.dolar, withCurrency: "")
        tfIOF.text = tc.gerFormmaterValue(of: tc.iof, withCurrency: "")
        tfStateTaxes.text = tc.gerFormmaterValue(of: tc.stateTax, withCurrency: "")
    }

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //Esconder o teclado
        view.endEditing(true);
    }
    
    func setValues() {
        tc.dolar = tc.convertToDouble(self.tfDolar.text!)
        tc.iof = tc.convertToDouble(self.tfIOF.text!)
        tc.stateTax = tc.convertToDouble(self.tfStateTaxes.text!)
    }

}

extension SettingsViewController: UITextFieldDelegate{
    func textFieldDidEndEditing(_ textField: UITextField) {
        setValues();
    }
}
