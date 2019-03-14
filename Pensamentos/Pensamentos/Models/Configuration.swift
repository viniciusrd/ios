//
//  Configuration.swift
//  Pensamentos
//
//  Created by Vinicius Rodrigues on 08/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation

enum UserDefaultsKeys: String {
    case timeInterval = "timeInterval"
    case colorScheme  = "colorScheme"
    case autoRefresh = "autoRefresh"
}

class Configuration {
    
    let defaults = UserDefaults.standard;
    static var shared: Configuration = Configuration();
    
    var timeInterval: Double{
        get{
            return defaults.double(forKey: UserDefaultsKeys.timeInterval.rawValue);
        }
        set{
            defaults.set(newValue, forKey: UserDefaultsKeys.timeInterval.rawValue)
        }
    }
    
    var colorScheme: Int{
        get{
            return defaults.integer(forKey: UserDefaultsKeys.colorScheme.rawValue);
        }
        set{
            defaults.set(newValue, forKey: UserDefaultsKeys.colorScheme.rawValue)
        }
    }
    
    var autoRefresh: Bool{
        get{
            return defaults.bool(forKey: UserDefaultsKeys.autoRefresh.rawValue);
        }
        set{
            defaults.set(newValue, forKey: UserDefaultsKeys.autoRefresh.rawValue)
        }
    }
    
    private init(){
        if(defaults.double(forKey: UserDefaultsKeys.timeInterval.rawValue) == 0){
            defaults.set(8.0, forKey: UserDefaultsKeys.timeInterval.rawValue);
        }
    }
    
    
    
}
