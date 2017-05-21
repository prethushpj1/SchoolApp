//
//  ViewController.swift
//  SchoolApp
//
//  Created by Prethush on 19/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class LoginController: BaseController, UITextFieldDelegate {

    @IBOutlet weak var vwLoginID: UIView!
    @IBOutlet weak var vwPassword: UIView!
    @IBOutlet weak var txtLoginID: UITextField!
    @IBOutlet weak var txtPassword: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vwLoginID.layer.borderColor = UIColor.gray.cgColor
        vwLoginID.layer.borderWidth = 1.0
        
        vwPassword.layer.borderColor = UIColor.gray.cgColor
        vwPassword.layer.borderWidth = 1.0
        
        txtLoginID.delegate = self
        txtPassword.delegate = self
        
        self.hideBackButton(status: true)
        self.hideStatusBar(status: false)
        self.title = "Login"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if self.areAllFieldsFilled(){
            self.getAPIServices().loginWith(userName: txtLoginID.text!, password: txtPassword.text!) { (response, error) in
                if (error == nil) {
                    self.getSharedData().username = self.txtLoginID.text!
                    self.getSharedData().password = self.txtPassword.text!
                    self.getSharedData().isLoggedIn = true
                    self.getAppDelegate().homeData = response
                    self.closeScreen(parameters: ["isLoggedIn" : true])
                }
                else{
                    self.showAlert(WithTitle: nil, Message: "Unable to login. Please try again", OKButtonTitle: "Ok", OKButtonAction: nil, CancelButtonTitle: nil, CancelButtonAction: nil)
                }
            }
        }
    }

    @IBAction func registerAction(_ sender: Any) {
        //self.openScreen(WithName: .register, paramters: [:])
    }
 
    func areAllFieldsFilled() -> Bool{
        if let loginEmail = txtLoginID.text, loginEmail.isEmpty {
            return false
        }
        else if let loginPassword = txtPassword.text, loginPassword.isEmpty{
            return false
        }
        return true
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        if textField == txtLoginID {
            txtPassword.becomeFirstResponder()
        }
        if textField == txtPassword {
            textField.resignFirstResponder()
        }
        return true
    }
}

