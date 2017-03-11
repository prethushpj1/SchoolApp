//
//  HomeController.swift
//  SchoolApp
//
//  Created by Prethush on 19/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class HomeController: BaseController {
    
    @IBOutlet weak var tblHomeMenu: UITableView!
    @IBOutlet weak var tblHomeActivity: UITableView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var lblSchoolName: UILabel!
    @IBOutlet weak var lblSchoolLocation: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let loggedIn = self.getSharedData().isLoggedIn, loggedIn == false{
            self.openScreen(WithName: .login, paramters: nil)
        }
        
        self.tblHomeMenu.delegate = self
        self.tblHomeMenu.dataSource = self
        
        self.tblHomeActivity.dataSource = self
        self.tblHomeActivity.delegate = self
        
        self.imgHeader.layer.cornerRadius = self.imgHeader.frame.size.width / 2
        self.imgHeader.layer.masksToBounds = true
        
        self.btnMenu.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
        
        self.getAPIServices().getHomeData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menuButtonPressed(){
        self.showWallMenu()
    }

}

extension HomeController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblHomeMenu{
            return 44.0
        }
        else{
            if indexPath.row % 2 == 0 {
                return 100.0
            }
            else{
                return 85.0
            }
        }
    }
}

extension HomeController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblHomeMenu{
            let homeMenuCell = tableView.dequeueReusableCell(withIdentifier: "homeMenuCell", for: indexPath) as! HomeMenuCell
            homeMenuCell.setDataForIndex(index: indexPath.row)
            return homeMenuCell
        }
        else{
            if indexPath.row % 2 == 0 {
                let homeMenuCell = tableView.dequeueReusableCell(withIdentifier: "homeActivityCell", for: indexPath) as! HomeActivityCell
                return homeMenuCell
            }
            else{
                let homeMenuCell = tableView.dequeueReusableCell(withIdentifier: "homeMessageCell", for: indexPath) as! HomeMessageCell
                return homeMenuCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblHomeMenu{
            return 3
        }
        else{
            return 8
        }
    }
}
