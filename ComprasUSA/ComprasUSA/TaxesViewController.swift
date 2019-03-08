//
//  TaxesViewController.swift
//  ComprasUSA
//
//  Created by Vinicius Rodrigues on 07/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import UIKit

class TaxesViewController: UIViewController {
    @IBOutlet weak var lbDolar: UILabel!
    @IBOutlet weak var lbStateTax: UILabel!
    @IBOutlet weak var lbIOF: UILabel!
    @IBOutlet weak var lbIOFDescription: UILabel!
    @IBOutlet weak var swCreditCard: UISwitch!
    @IBOutlet weak var lbStateTaxDescription: UILabel!
    @IBOutlet weak var lbTotal: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.calculateTaxes();
    }
    
    @IBAction func changeIOF(_ sender: UISwitch) {
        self.calculateTaxes()
    }
    
    func calculateTaxes()  {
        //Descricao
        lbStateTaxDescription.text = "Imposto do Estado (\(tc.gerFormmaterValue(of: tc.stateTax, withCurrency: ""))%)";
        lbIOFDescription.text = "IOF (\(tc.gerFormmaterValue(of: tc.iof, withCurrency: ""))%)";
        
        //Valores
        lbDolar.text = tc.gerFormmaterValue(of: tc.shoppingValue, withCurrency: "US$");
        lbStateTax.text = tc.gerFormmaterValue(of: tc.stateTaxValue, withCurrency: "US$");
        lbIOF.text = tc.gerFormmaterValue(of: tc.iofValue, withCurrency: "US$");
        
        let realValue = tc.calculate(usingCreditCard: swCreditCard.isOn);
        lbTotal.text = tc.gerFormmaterValue(of: realValue, withCurrency: "R$ ")
        
    }
}
