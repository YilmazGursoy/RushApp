//
//  RushLogger.swift
//  RushApp
//
//  Created by Most Wanted on 6.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class RushLogger {
    static func successLog(message:String){
        print("\n  ✅ \(message) - Response ✅ ")
    }
    
    static func errorLog(message:String) {
        print("\n  ❌ \(message) - Response ❌")
    }
    
    static func requestLog(message:String) {
        print("\n  🔥 \(message) 🔥")
    }
    
    static func functionLog(message:String) {
        print("\n  🌝 \(message) - Request 🎱")
    }
    
    static func credentialLog(message:String) {
        print("  🎽 \(message) Credential Setted 🎽")
    }
    
    static func functionParametersLog(message:Any?) {
        if message != nil {
            print("  📎 \(message!) 📎")
        } else {
            print("  📎 {} 📎")
        }
        
    }
}
