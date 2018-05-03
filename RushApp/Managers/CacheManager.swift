//
//  CacheManager.swift
//  RushApp
//
//  Created by Most Wanted on 3.05.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

class CacheManager {
    static let shared = CacheManager()
    
    func cache(object _object:Any, withKey key:String) {
        let defaults = UserDefaults.standard
        defaults.set(_object, forKey: key)
        defaults.synchronize()
    }
    
    func getCachedObject(withKey key:String) -> Any? {
        let defaults = UserDefaults.standard
        return defaults.object(forKey: key)
    }
    
}
