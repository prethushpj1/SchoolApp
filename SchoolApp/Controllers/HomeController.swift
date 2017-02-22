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
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        if let loggedIn = self.getSharedData().isLoggedIn, loggedIn == false{
            self.openScreen(WithName: .login, paramters: nil, completion: nil)
        }
        
        self.tblHomeMenu.delegate = self
        self.tblHomeMenu.dataSource = self
        
//        self.tblHomeActivity.dataSource = self
//        self.tblHomeActivity.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension HomeController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44.0
    }
}

extension HomeController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let homeMenuCell = tableView.dequeueReusableCell(withIdentifier: "homeMenuCell", for: indexPath) as! HomeMenuCell
        homeMenuCell.setDataForIndex(index: indexPath.row)
        return homeMenuCell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 3
    }
}
