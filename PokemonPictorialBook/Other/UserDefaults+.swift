//
//  UserDefaults+.swift
//  PokemonPictorialBook
//
//  Created by 土橋正晴 on 2022/07/24.
//

import Foundation

extension UserDefaults {
    
    enum Key: String {
        case initFetch = "initFetch"
    }
    
    func setBool(key: Key, value: Bool) {
        UserDefaults.standard.set(value, forKey: key.rawValue)
    }
    
    
    func getBool(key: Key) -> Bool {
        guard let value = UserDefaults.standard.object(forKey: key.rawValue) as? Bool else {
            return false
        }
        return value
    }
        
}
