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
    case myAttendace
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
        case .myAttendace:
            return "myAttendance"
        }
    }
}

extension Date{
    func shortString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "MMMM yyyy"
        return dateFormatter.string(from: self)
    }
}

extension String{
    func toDateWithoutTime() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd/MM/yyyy hh:mm:ss a"
        let dateObj = dateFormatter.date(from: self)
        dateFormatter.dateFormat = "dd-MM-yyyy"
        return dateFormatter.string(from: dateObj ?? Date())
    }
    
    func toDictionary() -> [String: Any]?{
        if let data = self.data(using: .utf8) {
            do {
                let json = try JSONSerialization.jsonObject(with: data, options: .allowFragments) as? [String:Any]
                return json
            } catch let error as NSError{
                print(error.debugDescription)
                return nil
            }
        }
        return nil
    }
    
    var isEmail: Bool {
        do {
            let regex = try NSRegularExpression(pattern: "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$",
                                                options: .caseInsensitive)
            return regex.firstMatch(in: self,
                                    options: NSRegularExpression.MatchingOptions(rawValue: 0),
                                    range: NSMakeRange(0, self.characters.count)) != nil
        } catch {
            return false
        }
    }
}
