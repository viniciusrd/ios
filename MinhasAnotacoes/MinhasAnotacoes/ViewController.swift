//
//  ViewController.swift
//  MinhasAnotacoes
//
//  Created by Vinícius Rodrigues Duarte on 27/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    let chave = "MinhaAnotacao";

    @IBOutlet weak var campoAnotacao: UITextView!
    @IBAction func botaoSalvarAnotacao(_ sender: Any) {
        
        if let textoAnotacao = campoAnotacao.text{
        
            UserDefaults.standard.set(textoAnotacao, forKey: chave);
        
        }
    }
    
    func recuperarAnotacao() -> String{
        
        if let anotacaoRecuperada = UserDefaults.standard.object(forKey: chave){
            
            return anotacaoRecuperada as! String;
        }
        return "";
    }
    
    //Esconder toolbar
    override var prefersStatusBarHidden: Bool{
        return true;
    }
    
    //metodo recupera touch do usuario em qualquer area da tela
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //esconder o teclado
        view.endEditing(true);
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        campoAnotacao.text = recuperarAnotacao();
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

