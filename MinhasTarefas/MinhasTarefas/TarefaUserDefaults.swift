//
//  TarefaUserDefaults.swift
//  MinhasTarefas
//
//  Created by Vinícius Rodrigues Duarte on 28/06/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class TarefaUserDefaults  {
    
    let chave = "Tarefas";
    var tarefas: [ String ] = [];
    
    func salvar(tarefa: String){
    
        // Recuperar tarefas ja salvas
        tarefas = listar();
        //Salvar tarefa
        tarefas.append(tarefa);
        UserDefaults.standard.set(tarefas, forKey: chave);
        
    }
    
    func listar() -> Array<String>{
        
        let dados = UserDefaults.standard.object(forKey: chave);
        if dados != nil {
            return dados as! Array<String>;
        }
        else{
            return [];
        }
    }
    
    func remover(index: Int)  {
        
        tarefas = listar();
        tarefas.remove(at: index);
        UserDefaults.standard.set( tarefas, forKey: chave );
    }
}
