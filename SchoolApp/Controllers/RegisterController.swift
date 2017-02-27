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
    @IBOutlet weak var backButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()

        vxFullName.layer.borderColor = UIColor.gray.cgColor
        vxFullName.layer.borderWidth = 1.0
        
        vxContact.layer.borderColor = UIColor.gray.cgColor
        vxContact.layer.borderWidth = 1.0
        
        vwEmail.layer.borderColor = UIColor.gray.cgColor
        vwEmail.layer.borderWidth = 1.0
        
        vxAddress.layer.borderColor = UIColor.gray.cgColor
        vxAddress.layer.borderWidth = 1.0
        
        vxPassword.layer.borderColor = UIColor.gray.cgColor
        vxPassword.layer.borderWidth = 1.0
        
        vxRePassword.layer.borderColor = UIColor.gray.cgColor
        vxRePassword.layer.borderWidth = 1.0
        
        self.backButton.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func registerAction(_ sender: Any) {
        
    }
}
