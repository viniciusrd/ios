//
//  ViewController.swift
//  Meus Filmes
//
//  Created by Vinícius Rodrigues Duarte on 26/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class ViewController: UITableViewController {
    
    var filmes: [Filme] = [];

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        var filme : Filme;
        filme = Filme( titulo: "007 - Spectre", descricao: "Descricao 1",imagem: #imageLiteral(resourceName: "filme1"));
        filmes.append( filme );
        
        filme = Filme( titulo: "Star Wars", descricao: "Descricao 2",imagem: #imageLiteral(resourceName: "filme2"));
        filmes.append( filme );
        
        filme = Filme( titulo: "Impacto Mortal", descricao: "Descricao 3",imagem: #imageLiteral(resourceName: "filme3"));
        filmes.append( filme );
        
        filme = Filme( titulo: "DeadPool", descricao: "Descricao 4",imagem: #imageLiteral(resourceName: "filme2"));
        filmes.append( filme );
        
        filme = Filme( titulo: "O Regresso", descricao: "Descricao 5",imagem:#imageLiteral(resourceName: "filme5"));
        filmes.append( filme );
        
        filme = Filme( titulo: "A Herdeira", descricao: "Descricao 6",imagem: #imageLiteral(resourceName: "filme6"));
        filmes.append( filme );
        
        filme = Filme( titulo: "Caçadores de Emoção", descricao: "Descricao 7",imagem: #imageLiteral(resourceName: "filme7"));
        filmes.append( filme );
        
        filme = Filme( titulo: "Regresso do Mal", descricao: "Descricao 8",imagem: #imageLiteral(resourceName: "filme8"));
        filmes.append( filme );
        
        filme = Filme( titulo: "Tarzan", descricao: "Descricao 9",imagem: #imageLiteral(resourceName: "filme9"));
        filmes.append( filme );
        
        filme = Filme( titulo: "Harcore", descricao: "Descricao 10",imagem: #imageLiteral(resourceName: "filme10"));
        filmes.append( filme );
        
        
    }
    
    //Define o num de sessoes
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1;
    }
    
    //Retorna numero de itens
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return filmes.count;
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let filme = filmes[indexPath.row];
        let celulaReuso = "celulaFilme"
        //convertendo a celula padrao para minha FilmeCelula
        let celula = tableView.dequeueReusableCell(withIdentifier: celulaReuso, for: indexPath) as! FilmeCelula;
        celula.imageView?.image = filme.imagem;
        celula.tituloFilmeLabel.text = filme.titulo;
        celula.descricaoFilmeLabel.text = filme.descricao;
        
        //arredondando imagens
//        celula.filmeImageView.layer.cornerRadius = 42;
//        celula.filmeImageView.clipsToBounds = true;
        
//        celula.textLabel?.text = filme.titulo;
//        celula.imageView?.image = filme.imagem;
        
        return celula;
        
    }
    
    // metado para passar dados entre view controller
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "detalheFilmeSegue"{
            
            if let indexPath = tableView.indexPathForSelectedRow{
                let filmeSelecionado = self.filmes[ indexPath.row ];
                let viewControllerDestino = segue.destination as! DetalhesFilmeViewController;
                
                viewControllerDestino.filme = filmeSelecionado;
            }
            
        }
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

