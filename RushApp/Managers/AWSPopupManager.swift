//
//  AWSPopupManager.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 30.08.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

protocol AWSPopupManagerProtocol {
    func showSuccess(message:String)
    func showErrorMessage(message:String)
    
}

class AWSPopupManager {
    static let shared = AWSPopupManager()
    var delegate:AWSPopupManagerProtocol!
    
    func showSuccessMessage(message:String) {
        self.delegate.showSuccess(message: message)
    }
    
    func showErrorMessage(message:String) {
        self.delegate.showErrorMessage(message: message)
    }
    
}
