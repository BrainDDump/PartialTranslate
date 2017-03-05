//
//  TranslateAPIManager.swift
//  Hacktech17
//
//  Created by KirillDubovitskiy on 3/5/17.
//  Copyright © 2017 BrainDump. All rights reserved.
//

import Alamofire
import PromiseKit

class TranslateAPIManager {
    static var shared = TranslateAPIManager.init()
    
    private let baseURL = "http://localhost:8080"
    
    func translate(text: String, targetLanguage: String, difficulty: Double) -> Promise<String> {
        let (promise, fulfill, reject) = Promise<String>.pending()
        
        let parameters: [String: Any] = [
            "text": text,
            "targetLanguage": targetLanguage,
            "difficulty": difficulty
        ]
        Alamofire.request(baseURL + "/partialtranslate", method: .post, parameters: parameters, encoding: JSONEncoding.default)
            .validate()
            .responseJSON { (dataResponse) in
                guard dataResponse.error == nil else {
                    reject(NSError.init(domain: "TranslateAPIManager", code: 400))
                    return
                }
                
                guard let responseDictionary = dataResponse.result.value as? [String: String],
                    let translation = responseDictionary["translation"] else {
                    reject(NSError.init(domain: "TranslateAPIManager", code: 401))
                    return
                }
                
                fulfill(translation)
        }
        
        return promise
    }
}
