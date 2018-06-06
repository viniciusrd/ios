//
//  ViewController.swift
//  Alcool ou Gasolina
//
//  Created by Vinícius Rodrigues Duarte on 01/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    
    
    @IBOutlet weak var resultadoLegenda: UILabel!
    @IBOutlet weak var precoGasolinaCampo: UITextField!
    @IBOutlet weak var precoAlcoolCampo: UITextField!
    
    @IBAction func calcularMelhorOpcao(_ sender: Any) {
        
        if let precoAlcool = precoAlcoolCampo.text{
            if let precoGasolina = precoGasolinaCampo.text{
                //validar
                if let validaCampos = self.validarCampos(precoAlcool: precoAlcool, precoGasolina: precoGasolina){
                    
                    if validaCampos {
                        //melhor combustivel
                        calcularMelhorPreco(precoAlcool: precoAlcool, precoGasolina: precoGasolina);
                    }
                    else{
                        resultadoLegenda.text = "Ops! Você esqueceu de digitar os preços.";
                    }
                }
                
            }
        }
    }
    
    func validarCampos(precoAlcool: String, precoGasolina: String) -> Bool {
        var camposValidados: Bool = true;
        
        if precoAlcool.isEmpty{
            camposValidados = false;
        }else if precoGasolina.isEmpty{
            camposValidados = false;
        }
        
        return camposValidados;
    }
    
    func calcularMelhorPreco(precoAlcool: String, precoGasolina: String){
        
        if let valorAlcool = Double(precoAlcool){
            if let valorGasolina = Double(precoGasolina){
                
                var resultado = (valorAlcool / valorGasolina);
                
                if resultado >= 0.7 {
                    self.resultadoLegenda.text = "É melhor utilizar GASOLINA !";
                }
                else{
                    self.resultadoLegenda.text = "É melhor utilizar ÁLCOOL !";
                }
                
            }
            
        }
    
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

