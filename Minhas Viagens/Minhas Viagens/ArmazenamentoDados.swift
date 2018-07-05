//
//  ArmazenamentoDados.swift
//  Minhas Viagens
//
//  Created by Vinícius Rodrigues Duarte on 03/07/18.
//  Copyright © 2018 Vinícius Rodrigues Duarte. All rights reserved.
//

import UIKit

class ArmazenamentoDados {
    
    let keyStorage = "locaisViagem"
    var travels:[Dictionary<String, String>] = [];
    
    func getDefaults() -> UserDefaults{
        return UserDefaults.standard
    }
    
    func toSaveTravel(travel: Dictionary<String,String>){
        self.travels = toListTravel();
        self.travels.append(travel);
        getDefaults().set(self.travels, forKey: keyStorage);
        getDefaults().synchronize();
        
    }
    
    func toListTravel() -> [Dictionary<String, String>] {
        let dados = getDefaults().object(forKey: keyStorage);
        if dados != nil{
            return dados as! Array;
        }else{
            return [];
        }
    }
    
    func toRemoveTravel(index: Int) {
        travels = toListTravel();
        travels.remove(at: index);
        
        getDefaults().set(self.travels, forKey: keyStorage);
        getDefaults().synchronize();
    }
    
}
