//
//  QuotesManager.swift
//  Pensamentos
//
//  Created by Vinicius Rodrigues on 08/03/19.
//  Copyright © 2019 Vinicius Rodrigues. All rights reserved.
//

import Foundation
class QuotesManager {
    
    let quotes: [Quote];
    
    init() {
        let fileURL = Bundle.main.url(forResource: "quotes", withExtension: "json")!;
        let jsonData = try! Data(contentsOf: fileURL);
        let jsonDecoder = JSONDecoder();
        quotes = try! jsonDecoder.decode([Quote].self, from: jsonData)
        
    }
    
    func gerRandomQuote() -> Quote {
        let index = Int(arc4random_uniform(UInt32(self.quotes.count)));
        return self.quotes[index];
    }
    
}
