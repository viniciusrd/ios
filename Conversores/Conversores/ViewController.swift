//
//  ViewController.swift
//  Conversores
//
//  Created by Vinícius Rodrigues Duarte on 16/08/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var tfValue: UITextField!
    @IBOutlet weak var btUnit1: UIButton!
    @IBOutlet weak var btUnit2: UIButton!
    @IBOutlet weak var lbResult: UILabel!
    @IBOutlet weak var lbResultUnit: UILabel!
    @IBOutlet weak var unit: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func showNext(_ sender: UIButton) {
        
        switch unit.text! {
                case "Temperatura":
                    unit.text = "Peso";
                    btUnit1.setTitle("Kilograma", for: .normal);
                    btUnit2.setTitle("Libra", for: .normal);
                case "Peso":
                    unit.text = "Moeda";
                    btUnit1.setTitle("Real", for: .normal);
                    btUnit2.setTitle("Dólar", for: .normal);
                case "Moeda":
                    unit.text = "Distância";
                    btUnit1.setTitle("Metro", for: .normal);
                    btUnit2.setTitle("Kilômetro", for: .normal)
                default:
                    unit.text = "Temperatura";
                    btUnit1.setTitle("Celsius", for: .normal);
                    btUnit2.setTitle("Farenheint", for: .normal)
                }
        convert(nil);
        view.endEditing(true);
        let result = Double(lbResult.text!)!;
        lbResultUnit.text = String(format: "%.2f", result);
    }
    
    @IBAction func convert(_ sender: UIButton?) {
        
        if let sender = sender{
         
            if sender == btUnit1{
                btUnit2.alpha = 0.5;
            }else{
                btUnit1.alpha = 0.5;
            }
            sender.alpha = 1.0;
            
            switch unit.text! {
                case "Temperatura":
                    calcTemperatura();
                case "Peso":
                    calcWeigth();
                case "Moeda":
                    calcCurrency();
                default:
                    calcDistance();
            }
            
        }
    }
    
    func calcTemperatura() {
        guard let temperature = Double(tfValue.text!) else {return}
        if btUnit1.alpha == 1.0{
            lbResultUnit.text = "Farenheint"
            lbResult.text = String( temperature * 1.8 + 32.0);
        }else{
            lbResultUnit.text = "Celsius"
            lbResult.text = String( (temperature - 32.0) / 1.8);
        }
    }
    func calcWeigth() {
        guard let weight = Double(tfValue.text!) else {return}
        if btUnit1.alpha == 1.0{
            lbResultUnit.text = "Libra"
            lbResult.text = String( weight / 2.2046);
        }else{
            lbResultUnit.text = "Kilograma"
            lbResult.text = String( weight * 2.2046);
        }
    }
    func calcCurrency() {
        guard let currency = Double(tfValue.text!) else {return}
        if btUnit1.alpha == 1.0{
            lbResultUnit.text = "Dólar"
            lbResult.text = String( currency / 3.5);
        }else{
            lbResultUnit.text = "Real"
            lbResult.text = String( currency * 3.5);
        }
    }
    func calcDistance() {
        guard let distance = Double(tfValue.text!) else {return}
        if btUnit1.alpha == 1.0{
            lbResultUnit.text = "Kilômetro"
            lbResult.text = String( distance / 1000.0);
        }else{
            lbResultUnit.text = "Metros"
            lbResult.text = String( distance * 1000.0);
        }
    }

}

