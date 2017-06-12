//
//  AttendanceReportController.swift
//  SchoolApp
//
//  Created by Prethush on 28/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class PaymentsController: UIViewController {
    
    @IBOutlet weak var tblReport: UITableView!
    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblSelectedAmount: UILabel!
    
    let homeData = AppDelegate.getAppDelegate().homeData
    var feesToDisplay: [ENFee]?
    var selectedFeesArray = [ENFee]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showStatusBar(status: true)
        self.showBackButton(status: true)
        self.showMenuButton(status: true)
        
        tblReport.delegate = self
        tblReport.dataSource = self
        
        self.title = "Payments"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnStudentAction(_ sender: Any) {
        
        ActionSheetStringPicker.show(withTitle: "Select student", rows: self.homeData?.model?.userInfo?.childrenNames(), initialSelection: 0, doneBlock: { (picker, row, name) in
            print("selected \(name ?? "")")
            self.lblStudentName.text = String(describing: name ?? "")
            self.feesToDisplay = self.homeData?.model?.userInfo?.children?[row].fees
            self.tblReport.reloadData()
        }, cancel: { (picker) in
            print("picker cancelled")
        }, origin: sender)
    }
    
    @IBAction func makePaymentAction(_ sender: Any) {
        
    }
    
    func updatePayment(){
        let totalAmount = self.getSelectedTotalAmount()
        
        self.lblSelectedAmount.text = "Selected total amount = \(totalAmount)"
    }
    
    func getSelectedTotalAmount() -> Double{
        var totalAmount = 0.0
        for fee in self.selectedFeesArray {
            let amt = fee.amount ?? 0
            let fine = fee.fine ?? 0
            totalAmount += amt + fine
        }
        return totalAmount
    }
}

extension PaymentsController: UITableViewDelegate, UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60.0
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let fees = self.feesToDisplay{
            return fees.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let attendanceCell = tableView.dequeueReusableCell(withIdentifier: "PaymentCell", for: indexPath) as! PaymentCell
        attendanceCell.set(Data: self.feesToDisplay![indexPath.row])
        return attendanceCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.selectedFeesArray.append(self.feesToDisplay![indexPath.row])
        self.updatePayment()
    }
    
    func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
        for i in 0..<self.selectedFeesArray.count {
            let obj = self.selectedFeesArray[i]
            if obj === self.feesToDisplay![indexPath.row] {
                self.selectedFeesArray.remove(at: i)
                break
            }
        }
        self.updatePayment()
    }
}

