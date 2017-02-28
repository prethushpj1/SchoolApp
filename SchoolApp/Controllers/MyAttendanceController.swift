//
//  MyAttendanceController.swift
//  SchoolApp
//
//  Created by Prethush on 25/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class MyAttendanceController: BaseController {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var fromDate: UIButton!
    @IBOutlet weak var toDate: UIButton!
    
    @IBOutlet weak var tblAttendance: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnBack.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        self.btnMenu.addTarget(self, action: #selector(showWallMenu), for: .touchUpInside)
        
        self.tblAttendance.delegate = self
        self.tblAttendance.dataSource = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension MyAttendanceController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension MyAttendanceController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let attendanceCell = tableView.dequeueReusableCell(withIdentifier: "AttendanceCell", for: indexPath) as! AttendanceCell
        
        switch indexPath.row {
        case 0:
            attendanceCell.firstHalfPresent(status: true)
            attendanceCell.secondHalfPresent(status: false)
            break
        case 1:
            attendanceCell.firstHalfPresent(status: false)
            attendanceCell.secondHalfPresent(status: true)
            break
        case 2:
            attendanceCell.firstHalfPresent(status: false)
            attendanceCell.secondHalfPresent(status: false)
            break
        default:
            attendanceCell.firstHalfPresent(status: true)
            attendanceCell.secondHalfPresent(status: true)
        }
        return attendanceCell
    }
}
