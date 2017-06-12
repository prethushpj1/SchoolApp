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
    @IBOutlet weak var scrollContent: UIScrollView!
    var activeTextField: UITextField?
    @IBOutlet weak var vwFieldContent: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        vwLoginID.layer.borderColor = UIColor.gray.cgColor
        vwLoginID.layer.borderWidth = 1.0
        
        vwPassword.layer.borderColor = UIColor.gray.cgColor
        vwPassword.layer.borderWidth = 1.0
        
        txtLoginID.delegate = self
        txtPassword.delegate = self
        
        self.showBackButton(status: false)
        self.showStatusBar(status: true)
        self.title = "Login"
        
        super.scrollContentView = self.scrollContent
        
        vwFieldContent.layer.borderColor = UIColor.gray.cgColor
        vwFieldContent.layer.borderWidth = 1.0
        vwFieldContent.layer.cornerRadius = 10.0
        vwFieldContent.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        if self.areAllFieldsFilled(){
            self.activeTextField?.resignFirstResponder()
            
            self.getAPIServices().loginWith(userName: txtLoginID.text!, password: txtPassword.text!) { (response, error) in
                if (error == nil) {
                    self.getSharedData().username = self.txtLoginID.text!
                    self.getSharedData().password = self.txtPassword.text!
                    self.getSharedData().isLoggedIn = true
                    self.getAppDelegate().homeData = response
                    
                    self.performSegue(withIdentifier: "loginSuccess", sender: self)
                }
                else{
                    self.showAlert(Message: "Unable to login. Please try again")
                }
            }
        }
    }

    @IBAction func registerAction(_ sender: Any) {
        self.performSegue(withIdentifier: ScreenName.register.string, sender: self)
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
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
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

