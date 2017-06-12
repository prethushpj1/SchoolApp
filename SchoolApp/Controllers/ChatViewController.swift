//
//  ChatViewController.swift
//  SchoolApp
//
//  Created by Prethush on 10/06/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class ChatViewController: UIViewController {

    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var vxOutline: UIView!
    @IBOutlet weak var lblParentName: UITextField!
    @IBOutlet weak var lblSubject: UITextField!
    @IBOutlet weak var txtBody: UITextView!
    @IBOutlet weak var lblPlaceholder: UILabel!
    
    let homeData = AppDelegate.getAppDelegate().homeData
    var selectedStudent: EnStudentInfo?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if txtBody.text.characters.count == 0 {
            self.lblPlaceholder.isHidden = false
        }
        else{
            self.lblPlaceholder.isHidden = true
        }
        self.showStatusBar(status: true)
        self.showBackButton(status: true)
        self.showMenuButton(status: true)
    
        self.vxOutline.layer.cornerRadius = 10.0
        self.vxOutline.layer.borderColor = UIColor.lightGray.cgColor
        self.vxOutline.layer.borderWidth = 1.0
        self.vxOutline.layer.masksToBounds = true
        self.title = "Chat with Principal"
        self.vxOutline.layer.masksToBounds = true
        
        self.txtBody.delegate = self
        self.txtBody.layer.cornerRadius = 8.0
        self.txtBody.layer.borderColor = UIColor.lightGray.cgColor
        self.txtBody.layer.borderWidth = 1.0
        self.txtBody.layer.masksToBounds = true
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func studentNameButtonAction(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "Select student", rows: self.homeData?.model?.userInfo?.childrenNames(), initialSelection: 0, doneBlock: { (picker, row, name) in
            self.selectedStudent = self.homeData?.model?.userInfo?.children?[row]
            self.lblStudentName.text = String(describing: name ?? "")
        }, cancel: { (picker) in
            print("picker cancelled")
        }, origin: sender)
    }
    
    @IBAction func sendChatAction(_ sender: Any) {
        let data = ["Message" : txtBody.text ?? "", "SchoolID" : "1", "Sender" : lblParentName.text ?? "", "StudentID" : self.selectedStudent?.studentID ?? "" , "Subject" : lblSubject.text ?? ""] as [String : Any]
        let apiServices = APIServices()
        apiServices.sendChatToPrincipal(data: data) { (data, error) in
            
        }
    }
}

extension ChatViewController: UITextViewDelegate{
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        let userEnteredString = textView.text
        var enteredString = (userEnteredString! as NSString).replacingCharacters(in: range, with: text) as String
        
        if enteredString.characters.count == 0{
            self.lblPlaceholder.isHidden = false
        }
        else{
            self.lblPlaceholder.isHidden = true
        }
        
        return true
    }
}
