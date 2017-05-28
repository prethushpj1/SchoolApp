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
    var childrenList: [EnStudentInfo]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        tblList.delegate = self
        tblList.dataSource = self
        
        self.showStatusBar(status: true)
        self.showBackButton(status: true)
        self.showMenuButton(status: true)
        
        self.title = "Students"
        
        childrenList = AppDelegate.getAppDelegate().homeData?.model?.userInfo?.children
    }
    
    @IBAction func addStudent(_ sender: Any) {
        self.performSegue(withIdentifier: ScreenName.addStudent.string, sender: self)
    }

    override func backButtonAction(){
        self.performSegue(withIdentifier: "prepareForUnwind", sender: self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.destination is MyChildrensController, sender is EnStudentInfo {
            (segue.destination as? MyChildrensController)?.studentData = sender as? EnStudentInfo
        }
    }
}

extension MyChildrenListController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100.0
    }
}

extension MyChildrenListController: UITableViewDataSource{
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let info = childrenList{
            return info.count
        }
        return 0
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let attendanceCell = tableView.dequeueReusableCell(withIdentifier: "childrensList", for: indexPath) as! MyChildrensListCell
        attendanceCell.set(Data: childrenList![indexPath.row])
        attendanceCell.selectionStyle = .none
        return attendanceCell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.performSegue(withIdentifier: ScreenName.addStudent.string, sender: childrenList![indexPath.row])
    }
}
