//
//  RushResponse.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 4.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class RushResponse<U: Decodable>: Decodable  {
    var result:U?
    var error:Error?
    
    enum CodingKeys: String, CodingKey {
        case result =   "result"
        case error  =   "error"
    }
    
    required init(from decoder: Decoder) throws {
        
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        do {
            self.result = try U(from: container.superDecoder(forKey: .result))
        }
        catch {
                
        }
        
    }
}


struct BaseResult : Decodable {
    
}
