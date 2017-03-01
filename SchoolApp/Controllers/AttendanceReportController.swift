//
//  AttendanceReportController.swift
//  SchoolApp
//
//  Created by Prethush on 28/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class AttendanceReportController: BaseController {
    @IBOutlet weak var vwOutlineBox: UIView!
    @IBOutlet weak var tblReport: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        vwOutlineBox.layer.backgroundColor = UIColor(red: 255/255.0, green: 201/255.0, blue: 14/255.0, alpha: 1).cgColor
        vwOutlineBox.layer.masksToBounds = true
        
        tblReport.delegate = self
        tblReport.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension AttendanceReportController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 30.0
    }
}

extension AttendanceReportController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let attendanceCell = tableView.dequeueReusableCell(withIdentifier: "attendaceReport", for: indexPath) as! AttendanceReportCell
        
        return attendanceCell
    }
}
