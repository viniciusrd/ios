//
//  ViewController.swift
//  Preco Bitcoin
//
//  Created by Vinícius Rodrigues Duarte on 09/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var priceBitcoin: UILabel!
    @IBOutlet weak var buttonUpdate: UIButton!
    
    var activityIndicator: UIActivityIndicatorView = UIActivityIndicatorView();
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.getPriceBitcoin();
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    @IBAction func updatePriceBitcoin(_ sender: Any) {
        
        self.getPriceBitcoin();
        
    }
    
    func formatterPrice(price: NSNumber) -> String{
        
        let numberFormatter = NumberFormatter();
        numberFormatter.numberStyle = .decimal;
        numberFormatter.locale = Locale(identifier: "pt_BR");
        
        if let finalPrice = numberFormatter.string(from: price){
            return finalPrice;
        }
        
        return "0,00";
    }
    
    func getPriceBitcoin(){
        
        self.buttonUpdate.setTitle("Atualizando...", for: .normal);
        
        //criando o progress
        activityIndicator.center = self.view.center;
        activityIndicator.hidesWhenStopped = true;
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray;
        view.addSubview(activityIndicator);
        
        activityIndicator.startAnimating();
        
        if let url = URL(string: "https://blockchain.info/ticker"){
            let task = URLSession.shared.dataTask(with: url) { (data, request, error) in
                
                if error == nil{
                    
                    if let returnRequest = data{
                        do{
                            if let json = try JSONSerialization.jsonObject(with: returnRequest, options: []) as? [String: Any]{
                                if let brl = json["BRL"] as? [String: Any]{
                                    if let price = brl["buy"] as? Double{
                                        let priceFormatted = self.formatterPrice(price: NSNumber(value: price));
                                        
                                        //processo assíncrono para atualizar componente de interface
                                        DispatchQueue.main.async(execute: {
                                            self.priceBitcoin.text = "R$ " + priceFormatted;
                                            self.buttonUpdate.setTitle("Atualizar", for: .normal);
                                            self.activityIndicator.stopAnimating();
                                        })
                                        
                                        
                                        
                                    }
                                }
                                
                            }
                        }catch{
                        }
                    }
                }else{
                    
                }
                
            }
            task.resume();
        }
        
    }
    

}

