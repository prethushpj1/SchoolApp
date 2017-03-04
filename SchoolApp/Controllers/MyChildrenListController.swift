//
//  MyChildrenListController.swift
//  SchoolApp
//
//  Created by Prethush on 01/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class MyChildrenListController: UIViewController {

    @IBOutlet weak var tblList: UITableView!
    @IBOutlet weak var btnAddStudent: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblList.delegate = self
        tblList.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}

extension MyChildrenListController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension MyChildrenListController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 6
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let attendanceCell = tableView.dequeueReusableCell(withIdentifier: "childrensList", for: indexPath) as! MyChildrensListCell
        
        return attendanceCell
    }
}
