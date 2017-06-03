//
//  APIServices.swift
//  SchoolApp
//
//  Created by Prethush on 11/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import AlamofireObjectMapper
import Alamofire

class APIServices: NSObject {
    
    static let baseURL = "http://betnbid.mobi/IDWCF/vtop.svc/"
    var rootViewController: UIViewController{
        get{
            let navController = (AppDelegate.getAppDelegate().window?.rootViewController)! as! UINavigationController
            
            return navController.topViewController!
        }
    }
    
    func startLoadingView(){
        self.rootViewController.startAnimating(CGSize(width: 50, height: 50), type:.ballRotateChase, color:UIColor.green)
    }
    
    func stopLoadingView(){
        self.rootViewController.stopAnimating()
    }
    func loginWith(userName: String, password: String, handler:@escaping (_ response:EnHomeData?,_ error: Error?) -> Void){
        
        self.startLoadingView()
        Alamofire.request(APIServices.baseURL + "Parentlogin", method: .post, parameters: ["username":userName, "password": password, "SchoolID" : "1"], encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            self.stopLoadingView()
            let jsonString = String(describing: response.value ?? "")
            if let parserdData = jsonString.toDictionary(){
                let homeEn = EnHomeData(JSON: parserdData)
                DispatchQueue.main.async {
                    handler(homeEn, nil)
                }
            }
        }
    }
    
    func registerWith(parameters: [String: Any], handler:@escaping (_ response:EnHomeData?,_ error: Error?) -> Void){
        
        self.startLoadingView()
        Alamofire.request(APIServices.baseURL + "ParentRegistration", method: .post, parameters: parameters, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            self.stopLoadingView()
            
            let jsonString = String(describing: response.value ?? "")
            if let parserdData = jsonString.toDictionary(){
                let homeEn = EnHomeData(JSON: parserdData)
                DispatchQueue.main.async {
                    handler(homeEn, nil)
                }
            }
        }
    }
    
    func addStudent(data: [String: Any], handler:@escaping (_ response:EnHomeData?,_ error: Error?) -> Void){
        self.startLoadingView()
        Alamofire.request(APIServices.baseURL + "ManageStudentDetails", method: .post, parameters: data, encoding: JSONEncoding.default, headers: nil).responseJSON { (response) in
            self.stopLoadingView()
            
            let jsonString = String(describing: response.value ?? "")
            if let parserdData = jsonString.toDictionary(){
                let homeEn = EnHomeData(JSON: parserdData)
                DispatchQueue.main.async {
                    handler(homeEn, nil)
                }
            }
        }
    }
}
