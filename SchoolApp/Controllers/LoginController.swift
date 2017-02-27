//
//  ViewController.swift
//  SchoolApp
//
//  Created by Prethush on 19/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class LoginController: BaseController {

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
        
        self.hideBackButton()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func loginAction(_ sender: Any) {
        self.getSharedData().isLoggedIn  = true
        self.closeScreen()
    }

    @IBAction func registerAction(_ sender: Any) {
        
    }
 
}

