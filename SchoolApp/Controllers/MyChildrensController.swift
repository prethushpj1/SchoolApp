//
//  MyChildrensController.swift
//  SchoolApp
//
//  Created by Prethush on 01/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class MyChildrensController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtClass: UITextField!
    @IBOutlet weak var txtRegisterNumber: UITextField!
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    
    var studentData: EnStudentInfo?
    var isMale = true
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.showStatusBar(status: true)
        self.showBackButton(status: true)
        self.showMenuButton(status: true)
        
        self.title = "Student Details"
        
        self.btnMale.layer.cornerRadius = 10
        self.btnMale.layer.borderColor = UIColor.gray.cgColor
        self.btnMale.layer.borderWidth = 1.0
        
        self.btnFemale.layer.cornerRadius = 10
        self.btnFemale.layer.borderColor = UIColor.gray.cgColor
        self.btnFemale.layer.borderWidth = 1.0
        
        self.btnMale.backgroundColor = UIColor.black
        self.btnFemale.backgroundColor = UIColor.white
        
        if let data = self.studentData{
            self.txtName.text = data.studentName
            self.txtClass.text = "\(data.className ?? "") \(data.division ?? "")"
            self.txtRegisterNumber.text = data.rollNo
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func maleButtonAction(_ sender: Any) {
        self.btnMale.backgroundColor = UIColor.black
        self.btnFemale.backgroundColor = UIColor.white
        
        self.isMale = true
    }
    
    @IBAction func femaleButtonAction(_ sender: Any) {
        self.btnMale.backgroundColor = UIColor.white
        self.btnFemale.backgroundColor = UIColor.black
        
        self.isMale = false
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
