//
//  RandomQuote+model.swift
//  RandomQuote
//
//  Created by fadel sultan on 6/26/20.
//  Copyright © 2020 fadel sultan. All rights reserved.
//

import Foundation

extension RandomQuoteVC {
    
    struct model : Codable{
        
        private var _id:String?
        var en:String?
        var author:String?
        var id:String?
        
        static func get(compilation:@escaping(_ result:model? , _ error:Error?)-> Void) {
            API.get { (result) in
                switch result {
                case .success(let data):
                    do {
                        let values = try JSONDecoder().decode(model.self, from: data)
                        compilation(values, nil)
                    }catch let error {
                        compilation(nil, error)
                    }
                case .failure(let error):
                    compilation(nil, error)
                }
            }
        }
    }
}
