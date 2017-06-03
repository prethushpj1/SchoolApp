//
//  MyChildrensController.swift
//  SchoolApp
//
//  Created by Prethush on 01/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class MyChildrensController: UIViewController {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var txtName: UITextField!
    @IBOutlet weak var txtAge: UITextField!
    @IBOutlet weak var txtBloodGroup: UITextField!
    @IBOutlet weak var txtClass: UITextField!
    @IBOutlet weak var txtRegisterNumber: UITextField!
    @IBOutlet weak var txtRollNumber: UITextField!
    @IBOutlet weak var txtFirstGuardian: UITextField!
    @IBOutlet weak var txtSecondGuardian: UITextField!
    
    @IBOutlet weak var btnMale: UIButton!
    @IBOutlet weak var btnFemale: UIButton!
    @IBOutlet weak var scrollContentView: UIScrollView!
    var activeTextField: UITextField?
    
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
            print(data.toJSONString(prettyPrint: true)!)
            self.txtName.text = data.studentName
            self.txtClass.text = "\(data.className ?? "") \(data.division ?? "")"
            txtAge.text = data.dob
            txtBloodGroup.text = data.bloodGroup
            txtClass.text = "\(data.className ?? "") \(data.division ?? "")"
            txtName.text = data.studentName
            txtRegisterNumber.text = data.registerNumber
            txtRollNumber.text = data.rollNo
            txtFirstGuardian.text = data.firstGuardian
            txtSecondGuardian.text = data.secondGuardian
            if data.gender == 2 {
                self.femaleButtonAction(2)
            }
            else{
                self.maleButtonAction(1)
            }
        }
        
        txtAge.delegate = self
        txtBloodGroup.delegate = self
        txtClass.delegate = self
        txtName.delegate = self
        txtRegisterNumber.delegate = self
        txtRollNumber.delegate = self
        txtFirstGuardian.delegate = self
        txtSecondGuardian.delegate = self
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
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

    // MARK: - Keyboard management
    func keyBoardWillShow(_ notification: Notification) {
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
    
    func keyboardWillHide(){
        let contentInsets = UIEdgeInsets.zero
        self.scrollContentView?.contentInset = contentInsets
        self.scrollContentView?.scrollIndicatorInsets = contentInsets
    }
    @IBAction func submit(_ sender: Any) {
        
        var serverData = [String:Any]()
        serverData["RollNo"] = txtRollNumber.text
        serverData["FirstGuardian"] = txtFirstGuardian.text
        serverData["SecondGuardian"] = txtSecondGuardian.text
        serverData["BloodGroup"] = txtBloodGroup.text
        serverData["DOB"] = txtAge.text
        serverData["Class"] = txtClass.text
        serverData["StudentName"] = txtName.text
        serverData["RollNo"] = txtRollNumber.text
        serverData["SchoolInfo"] = ["SchoolID" : "1"]
        
        let enStudent = EnStudentInfo(JSON: serverData)
        print(enStudent?.toJSON() ?? [:])
        
//        let api = APIServices()
//        api.addStudent(data: dataDictionary) { (response, error) in
//            
//        }
        
    }
}

extension MyChildrensController: UITextFieldDelegate{
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeTextField = textField
        
        if textField == txtAge {
            textField.resignFirstResponder()
            let picker = ActionSheetDatePicker(title: "Date of birth", datePickerMode: .date, selectedDate: Date(), doneBlock: { (picker, date, sender) in
                textField.text = (date as? Date)?.dateOnlyString()
            }, cancel: { (picker) in
            }, origin: textField)
            picker?.maximumDate = Date()
            picker?.show()
        }
        
        if textField == txtBloodGroup {
            textField.resignFirstResponder()
            ActionSheetStringPicker.show(withTitle: "Select student", rows: ["A+", "A-", "B+", "B-", "AB+", "AB-", "O+", "O-"], initialSelection: 0, doneBlock: { (picker, row, name) in
                textField.text = "\(name ?? "")"
            }, cancel: { (picker) in
            }, origin: textField)
        }
        
        if textField == txtClass {
            textField.resignFirstResponder()
            let divisions = ["A", "B", "C", "D"]
            let classes = ["1", "2", "3", "4", "5", "6", "7", "8", "9", "10"]
            
            ActionSheetMultipleStringPicker.show(withTitle: "Select class", rows: [classes, divisions], initialSelection: [0, 0], doneBlock: { (picker, data, sender) in
                let dataArray = data as? Array<Int>
                textField.text = "\(classes[(dataArray?[0])!]) \(divisions[(dataArray?[1])!])"
            }, cancel: { (picker) in
            }, origin: txtClass)
        }
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        if textField == txtName {
            txtRegisterNumber.becomeFirstResponder()
        }
        if textField == txtRegisterNumber {
            txtRollNumber.becomeFirstResponder()
        }
        if textField == txtRollNumber {
            txtFirstGuardian.becomeFirstResponder()
        }
        if textField == txtFirstGuardian {
            txtSecondGuardian.becomeFirstResponder()
        }
        if textField == txtSecondGuardian {
            textField.resignFirstResponder()
        }
        return true
    }
}
