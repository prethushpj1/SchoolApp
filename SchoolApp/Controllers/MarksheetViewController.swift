//
//  MarksheetViewController.swift
//  SchoolApp
//
//  Created by Prethush on 03/06/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0

class MarksheetViewController: UIViewController {

    @IBOutlet weak var lblStudentName: UILabel!
    @IBOutlet weak var lblTermName: UILabel!
    @IBOutlet weak var vwTerms: UIView!
    @IBOutlet weak var tblMarks: UITableView!
    
    var selectedStudentRow = 0
    let homeData = AppDelegate.getAppDelegate().homeData
    var selectedMarkList: [ENmark]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showStatusBar(status: true)
        self.showBackButton(status: true)
        self.showMenuButton(status: true)
        
        vwTerms.isHidden = true
        tblMarks.delegate = self
        tblMarks.dataSource = self
        
        self.title = "Marksheet"
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func studentNameAction(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "Select student", rows: self.homeData?.model?.userInfo?.childrenNames(), initialSelection: 0, doneBlock: { (picker, row, name) in
            
            self.lblStudentName.text = String(describing: name ?? "")
            self.vwTerms.isHidden = false
            self.selectedStudentRow = row
        }, cancel: { (picker) in
            
        }, origin: sender)
    }
    
    @IBAction func termButtonAction(_ sender: Any) {
        ActionSheetStringPicker.show(withTitle: "Select term", rows: self.homeData?.model?.userInfo?.children?[selectedStudentRow].getTermsList(), initialSelection: 0, doneBlock: { (picker, row, name) in
            
            self.lblTermName.text = String(describing: name ?? "")
            self.selectedMarkList = self.homeData?.model?.userInfo?.children?[self.selectedStudentRow].getMarklistFor(Term: String(describing: name ?? ""))
            
            self.tblMarks.reloadData()
        }, cancel: { (picker) in
            
        }, origin: sender)
    }
}

extension MarksheetViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let list = self.selectedMarkList{
            return list.count
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "marksheet") as! MarksheetTableViewCell
        cell.selectionStyle = .none
        cell.set(Data: self.selectedMarkList![indexPath.row])
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if let _ = self.selectedMarkList{
            return 30
        }
        return 0
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let header = tableView.dequeueReusableCell(withIdentifier: "header")
        return header
    }
}
