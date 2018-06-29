//
//  CadastroTarefaViewController.swift
//  MinhasTarefas
//
//  Created by Vinícius Rodrigues Duarte on 28/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class CadastroTarefaViewController: UIViewController {

    
    @IBOutlet weak var campoTarefa: UITextField!
    @IBAction func botaoAdicionarTarefa(_ sender: Any) {
        
        if let tarefaDigitado = campoTarefa.text{
            
            let tarefa = TarefaUserDefaults();
            tarefa.salvar(tarefa: tarefaDigitado);
            campoTarefa.text = "";
        }
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
