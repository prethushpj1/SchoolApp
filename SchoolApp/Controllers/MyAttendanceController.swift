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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.btnBack.addTarget(self, action: #selector(closeScreen), for: .touchUpInside)
        self.btnMenu.addTarget(self, action: #selector(showWallMenu), for: .touchUpInside)
    
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func btnStudentAction(_ sender: Any) {
        
    }
    
}
