//
//  Register.swift
//  SchoolApp
//
//  Created by Prethush on 19/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class RegisterController: BaseController {

    @IBOutlet weak var vxFullName: UIView!
    @IBOutlet weak var vxContact: UIView!
    @IBOutlet weak var vwEmail: UIView!
    @IBOutlet weak var vxAddress: UIView!
    @IBOutlet weak var vxPassword: UIView!
    @IBOutlet weak var vxRePassword: UIView!
    @IBOutlet weak var vxAddress2: UIView!
    @IBOutlet weak var vxCity: UIView!
    @IBOutlet weak var vxState: UIView!
    @IBOutlet weak var vxcountry: UIView!
    @IBOutlet weak var vxPincode: UIView!
    
    @IBOutlet weak var txtFullName: UITextField!
    @IBOutlet weak var txtPhone: UITextField!
    @IBOutlet weak var txtEmail: UITextField!
    @IBOutlet weak var txtAddress1: UITextField!
    @IBOutlet weak var txtAddress2: UITextField!
    @IBOutlet weak var txtCity: UITextField!
    @IBOutlet weak var txtState: UITextField!
    @IBOutlet weak var txtCountry: UITextField!
    @IBOutlet weak var txtPincode: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    @IBOutlet weak var txtRePassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.applyBorder(view: vxFullName)
        self.applyBorder(view: vxContact)
        self.applyBorder(view: vwEmail)
        self.applyBorder(view: vxAddress)
        self.applyBorder(view: vxPassword)
        self.applyBorder(view: vxRePassword)
        self.applyBorder(view: vxAddress2)
        self.applyBorder(view: vxCity)
        self.applyBorder(view: vxState)
        self.applyBorder(view: vxcountry)
        self.applyBorder(view: vxPincode)
        
        self.hideBackButton(status: false)
        self.hideStatusBar(status: false)
        self.title = "Register"
    }
    
    func applyBorder(view: UIView){
        view.layer.borderColor = UIColor.gray.cgColor
        view.layer.borderWidth = 1.0
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registerAction(_ sender: Any) {
        if self.areAllFieldsFilled() {
            let address = ["Address1": txtAddress1.text!,
                           "Address2" : txtAddress2.text!,
                           "City": txtCity.text!,
                           "Country": txtCountry.text!,
                           "Pincode" : txtPincode.text!,
                           "State" : txtState.text!]
            let parentInfo = ["Address" : address,
                              "EmailID" : txtEmail.text!,
                              "FullName" : txtFullName.text!,
                              "Password" : txtRePassword.text!,
                              "Phone" : txtPhone.text!,
                              "UserName" : txtEmail.text!,
                              "Status" : 1] as [String : Any]
            
            self.getAPIServices().registerWith(parameters: ["ParentInfo" :parentInfo], handler: { (response, error) in
                
            })
            
        }
    }
    
    func areAllFieldsFilled() -> Bool{
        if let value = txtFullName.text, value.isEmpty {
            return false
        }
        else if let value = txtPhone.text, value.isEmpty{
            return false
        }
        else if let value = txtEmail.text, value.isEmpty{
            return false
        }
        else if let value = txtAddress1.text, value.isEmpty{
            return false
        }
        else if let value = txtAddress2.text, value.isEmpty{
            return false
        }
        else if let value = txtCity.text, value.isEmpty{
            return false
        }
        else if let value = txtState.text, value.isEmpty{
            return false
        }
        else if let value = txtCountry.text, value.isEmpty{
            return false
        }
        else if let value = txtPincode.text, value.isEmpty{
            return false
        }
        return true
    }
}
