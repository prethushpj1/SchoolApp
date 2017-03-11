//
//  SoapParameters.swift
//  SchoolApp
//
//  Created by Prethush on 09/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class SoapParameters {
    fileprivate var parameters: [String: Any]? = Dictionary()
    
    init(WithKey key: String, andValue value:Any) {
        parameters?[key] = value
    }
    
    func addParameters(WithKey key: String, andValue value:Any){
        parameters?[key] = value
    }
    
    func getParameters() -> [String: Any]?{
        return parameters
    }
}
