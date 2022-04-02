//
//  UserSingletion.swift
//  SnapchatClone
//
//  Created by İSMAİL AÇIKYÜREK on 2.04.2022.
//

import Foundation

class UserSingleton {
    
    static let SharedUSerInfo = UserSingleton()
    var email = ""
    var username = ""
    
    
    private init() {
        
    }
}
