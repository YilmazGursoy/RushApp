//
//  ErrorConstants.swift
//  RushApp
//
//  Created by Most Wanted on 5.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct ErrorConstants {
    static let awsCognitoConfirmEmailCode           = 33
    static let awsCognitoFacebookCredentialNil      = 3
    static let awsCognitoSignoutCode                = -1000
    
    static let awsCognitoRegisterValidation         = 13 //Lütfen geçerli alanları doğru doldurunuz == email, telefon ve şifreniz en az 6 karakterden oluşmalıdır.
    static let awsCognitoRegisterNameAlreadyExist   = 37 // Girmiş olduğunuz telefon numarası sistemde mevcuttur lütfen yeni bir numara ile deneyiniz.
    static let noInternetConnection                 = -1009
}
