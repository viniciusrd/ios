//
//  ViewController.swift
//  geradornumeros
//
//  Created by Vinícius Rodrigues Duarte on 28/05/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    @IBOutlet weak var legendaResultado: UILabel!
    
    @IBAction func gerarNumero(_ sender: Any)
    {
        var numero = arc4random_uniform(11);
        legendaResultado.text = String(numero);
    }
    

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

