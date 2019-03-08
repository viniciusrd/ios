//
//  ViewController.swift
//  ComprasUSA
//
//  Created by Vinicius Rodrigues on 07/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class ShoppingViewController: UIViewController {

    @IBOutlet weak var tfDolar: UITextField!
    @IBOutlet weak var lbRealDesription: UILabel!
    @IBOutlet weak var lbReal: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated);
        setAmmount();
    }
    
    //Click na tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.tfDolar.resignFirstResponder();
        setAmmount();
    }

    func setAmmount()  {
        tc.shoppingValue =  tc.convertToDouble(tfDolar.text!);
        lbReal.text = tc.gerFormmaterValue(of: tc.shoppingValue * tc.dolar, withCurrency: "R$ ")
        let dolar = tc.gerFormmaterValue(of: tc.dolar, withCurrency: "")
        self.lbRealDesription.text = "Valor sem impostos ( dólar \(dolar))"
    }
}

