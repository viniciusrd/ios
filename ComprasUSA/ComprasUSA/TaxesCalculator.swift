//
//  TaxesCalculator.swift
//  ComprasUSA
//
//  Created by Vinicius Rodrigues on 08/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
class TaxesCalculator {
    
    //Criando um Singleton
    static let shared = TaxesCalculator();
    var dolar: Double = 3.5;
    var iof: Double = 6.48;
    var stateTax: Double = 7.0;
    var shoppingValue: Double = 0.0;
    
    let formatter  = NumberFormatter();
    
    //Variaveis computadas
    var shoppingValueInReal: Double{
        return self.shoppingValue * self.dolar;
    }
    
    var stateTaxValue: Double{
        return self.shoppingValue * self.stateTax/100;
    }
    
    var iofValue: Double{
        return (self.shoppingValue + stateTax) * self.iof/100;
    }
    
    func calculate(usingCreditCard: Bool) -> Double {
        
        var finalValue = self.shoppingValue + stateTax;
        if(usingCreditCard){
            finalValue += self.iofValue;
        }
        
        return finalValue * dolar;
    }
    
    func convertToDouble(_ string: String) -> Double {
        //nenhum estilo de numero
        formatter.numberStyle = .none
        return formatter.number(from: string)!.doubleValue
    }
    
    func gerFormmaterValue(of value:Double, withCurrency currency:String) -> String {
        formatter.numberStyle = .currency;
        formatter.currencySymbol = currency;
        formatter.alwaysShowsDecimalSeparator = true;
        return formatter.string(for: value)!;
    }
    
    private init(){
        formatter.usesGroupingSeparator = true;
    }
    
}
