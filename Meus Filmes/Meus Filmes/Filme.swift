//
//  Filme.swift
//  Meus Filmes
//
//  Created by Vinícius Rodrigues Duarte on 26/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class Filme  {
    var titulo: String!;
    var descricao: String!;
    var imagem: UIImage!;
    
    init(titulo: String, descricao: String, imagem: UIImage) {
        self.titulo = titulo;
        self.descricao = descricao;
        self.imagem = imagem;
    }
    
}
