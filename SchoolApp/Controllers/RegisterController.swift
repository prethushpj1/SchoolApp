//
//  Register.swift
//  SchoolApp
//
//  Created by Prethush on 19/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class RegisterController: BaseController, UITextFieldDelegate {

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
    @IBOutlet weak var scrollContain: UIScrollView!
    var activeTextField: UITextField?
    
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
        
        self.showBackButton(status: true)
        self.showStatusBar(status: true)
        self.title = "Register"
        
        super.scrollContentView = scrollContain
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
            
            let address = "{\"Address1\":\"\(txtAddress1.text!)\", \"Address2\":\"\(txtAddress2.text!)\",\"City\":\"\(txtCity.text!)\",\"Country\": \"\(txtCountry.text!)\",\"Pincode\" :\"\(txtPincode.text!)\",\"State\":\"\(txtState.text!)\"}"
            let parentInfo = "{\"Address\" :\(address),\"EmailID\" : \"\(txtEmail.text!)\",\"FullName\" : \"\(txtFullName.text!)\",\"Password\" : \"\(txtRePassword.text!)\",\"Phone\" : \"\(txtPhone.text!)\",\"UserName\" : \"\(txtEmail.text!)\",\"Status\" : 1}"
            let urlEncodString = parentInfo.urlEncoded()
            print(urlEncodString)
            self.getAPIServices().registerWith(parameters: ["ParentInfo" :urlEncodString], handler: { (response, error) in
                
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtFullName {
            txtPhone.becomeFirstResponder()
        }
        if textField == txtPhone {
            txtEmail.becomeFirstResponder()
        }
        if textField == txtEmail {
            txtAddress1.becomeFirstResponder()
        }
        if textField == txtAddress1 {
            txtAddress2.becomeFirstResponder()
        }
        if textField == txtAddress2 {
            txtCity.becomeFirstResponder()
        }
        if textField == txtCity {
            txtState.becomeFirstResponder()
        }
        if textField == txtState {
            txtCountry.becomeFirstResponder()
        }
        if textField == txtCountry {
            txtPincode.becomeFirstResponder()
        }
        if textField == txtPincode {
            txtPassword.becomeFirstResponder()
        }
        if textField == txtPassword {
            txtRePassword.becomeFirstResponder()
        }
        if textField == txtRePassword {
            txtRePassword.resignFirstResponder()
        }
        
        return true
    }

    
    // MARK: - Keyboard management
    override func keyBoardWillShow(_ notification: Notification) {
        // get keyboard height and scroll the view up
        
        var userInfo = notification.userInfo!
        let keyboardSize = (userInfo[UIKeyboardFrameBeginUserInfoKey] as! NSValue).cgRectValue.size
        
        let keyboardHeight = keyboardSize.height
        
        let contentInsets = UIEdgeInsetsMake(0.0, 0.0, keyboardHeight, 0.0)
        self.scrollContentView?.contentInset = contentInsets
        self.scrollContentView?.scrollIndicatorInsets = contentInsets
        
        var sRect = self.scrollContentView?.frame
        sRect?.size.height -= keyboardHeight
        
        if let textField = self.activeTextField{
            let textFieldPos = textField.convert(textField.bounds, from: self.scrollContentView)
            
            if let status = sRect?.contains(textFieldPos.origin), status == true {
                self.scrollContentView?.scrollRectToVisible(textFieldPos, animated: true)
            }
        }
    }
}
