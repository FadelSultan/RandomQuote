//
//  API.swift
//  RandomQuote
//
//  Created by fadel sultan on 6/26/20.
//  Copyright © 2020 fadel sultan. All rights reserved.
//

import Alamofire

class API {
    
    enum apiError: Error {
        case url
    }
    
    class func get(url:String =  URLs.quotesRandom , compilation:@escaping(_ result:Swift.Result<Data , Error>)-> Void) {
        guard let url = URL(string: url) else {
            compilation(.failure(apiError.url))
            return
        }
        AF.request(url).responseData{ (response) in
            switch response.result {
            case .failure(let error) :
                compilation(.failure(error))
            case .success(let data):
                compilation(.success(data))
            }
        }
    }
}
