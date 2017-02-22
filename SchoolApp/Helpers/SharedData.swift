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
        case isLoggedIn = "ISLOGGEDIN"
    }
    /// returns current user email id
    var isLoggedIn: Bool? {
        get {
            return UserDefaults.standard.object(forKey: SharedDataConstants.isLoggedIn.rawValue) as? Bool
        }
        set (isLoggedIn){
            UserDefaults.standard.set(isLoggedIn, forKey: SharedDataConstants.isLoggedIn.rawValue)
            UserDefaults.standard.synchronize()
        }
    }
}
