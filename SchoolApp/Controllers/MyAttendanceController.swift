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
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.btnBack.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        self.btnMenu.addTarget(self, action: #selector(showWallMenu), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
