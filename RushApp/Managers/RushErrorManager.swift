//
//  RushError.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

enum ErrorMessages{
    case userNotConfirmAlready
}

extension ErrorMessages {
    
    func getMessageText() -> String {
        switch self {
        case .userNotConfirmAlready:
            return "Lütfen mailinizi doğrulayınız."
        default:
            return ""
        }
        
    }
    
}

class RushErrorManager {
    
    
    
}
