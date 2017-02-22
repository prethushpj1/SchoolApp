//
//  Constants.swift
//  SchoolApp
//
//  Created by Prethush on 20/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

enum ScreenName{
    case login
    case register
    case home
}

extension ScreenName{
    var string: String{
        
        switch self {
        case .login:
            return "loginController"
        case .register:
            return "registerController"
        case .home:
            return "homeController"
        }
    }
}

extension UINavigationBar{
//    open override func sizeThatFits(_ size: CGSize) -> CGSize {
//        var rec = self.frame
//        let screenRect = UIScreen.main.bounds
//        rec.size.width = screenRect.size.width
//        rec.size.height = 70
//        return rec.size;
//    }
}
