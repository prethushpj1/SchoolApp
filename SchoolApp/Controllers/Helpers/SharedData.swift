//
//  SharedData.swift
//  SchoolApp
//
//  Created by Prethush on 21/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class SharedData: NSObject {
    fileprivate enum SharedDataConstants: String{
        case isLoggedIn = "SA_ISLOGGEDIN"
        case username = "SA_USERNAME"
        case password = "SA_PASSWORD"
    }
    /// returns current user email id
    var isLoggedIn: Bool {
        get {
            let status = UserDefaults.standard.object(forKey: SharedDataConstants.isLoggedIn.rawValue) as? Bool
            return status ?? false
        }
        set (isLoggedIn){
            UserDefaults.standard.set(isLoggedIn, forKey: SharedDataConstants.isLoggedIn.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    var username: String{
        get {
            let username = UserDefaults.standard.object(forKey: SharedDataConstants.username.rawValue) as? String
            return username ?? ""
        }
        set(username){
            UserDefaults.standard.set(username, forKey: SharedDataConstants.username.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
    
    var password: String{
        get {
            let password = UserDefaults.standard.object(forKey: SharedDataConstants.password.rawValue) as? String
            return password ?? ""
        }
        set(password){
            UserDefaults.standard.set(password, forKey: SharedDataConstants.password.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
