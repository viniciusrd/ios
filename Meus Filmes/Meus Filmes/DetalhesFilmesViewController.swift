//
//  DetalhesFilmesViewController.swift
//  Meus Filmes
//
//  Created by Vinícius Rodrigues Duarte on 27/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class DetalhesFilmeViewController: UIViewController {
    
    var filme: Filme!;
    
    @IBOutlet weak var detalheFilmeImageView: UIImageView!
    @IBOutlet weak var detalheTituloFilme: UILabel!
    @IBOutlet weak var detalheDescFilme: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad();
    
        detalheFilmeImageView.image = filme.imagem;
        detalheTituloFilme.text = filme.titulo;
        detalheDescFilme.text = filme.descricao
        
    }
}
