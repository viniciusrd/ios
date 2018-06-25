//
//  ViewController.swift
//  Signos
//
//  Created by Vinícius Rodrigues Duarte on 24/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var signos:[String] = [];
    var significadoSignos:[String] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        //signos
        signos.append("Áries");
        signos.append("Touro");
        signos.append("Gêmeos");
        signos.append("Câncer");
        signos.append("Leão");
        signos.append("Virgem");
        signos.append("Libra");
        signos.append("Escorpião");
        signos.append("Sagitário");
        signos.append("Capricórnio");
        signos.append("Áquário");
        signos.append("Peixes");
        
        //significado
        significadoSignos.append("Significado 1");
        significadoSignos.append("Significado 2");
        significadoSignos.append("Significado 3");
        significadoSignos.append("Significado 4");
        significadoSignos.append("Significado 5");
        significadoSignos.append("Significado 6");
        significadoSignos.append("Significado 7");
        significadoSignos.append("Significado 8");
        significadoSignos.append("Significado 9");
        significadoSignos.append("Significado 10");
        significadoSignos.append("Significado 11");
        significadoSignos.append("Significado 12");
        
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return signos.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let celularReuso: (String) = "celulaReuso";
        let celular = tableView.dequeueReusableCell(withIdentifier: celularReuso, for: indexPath)
        celular.textLabel?.text = signos[indexPath.row];
        
        return celular;
    }
    
    //trata o click dentro da linha da tabela
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //efeito para desmarcar a linha selecionada
        tableView.deselectRow(at: indexPath, animated: true);
        
        //Configurando o alert
        let alertaController = UIAlertController(
            title: "Significado do signo",
            message: significadoSignos[indexPath.row],
            preferredStyle: .alert
        );
        
        //configurando o botao confirmar
        let acaoConfirmar = UIAlertAction(
            title: "Ok",
            style: .default,
            handler: nil
        );
        
        alertaController.addAction(acaoConfirmar);
        
        present(alertaController, animated: true, completion: nil);
    }
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

