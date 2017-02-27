//
//  BaseController.swift
//  SchoolApp
//
//  Created by Prethush on 20/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class BaseController: UIViewController {

    let sharedData = SharedData()
    var wallMenu: WallMenu?
    override func viewDidLoad() {
        super.viewDidLoad()

        //self.getSharedData().isLoggedIn = true
        
        wallMenu = WallMenu.getInstance
        wallMenu?.delegate = self
        wallMenu?.dataArray = ["Home", "Attendance", "Fees", "Marksheet" , "Time table", "Messages" ,"Exmas", "School Diary", "Log out"]
        wallMenu?.imageNameArray = ["home" , "tickWhite", "fees-dark", "marklistLight", "calendarLight", "email", "email","email", "logout"]
        wallMenu?.title = "School Name"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openScreen(WithName name: ScreenName,
                    paramters: [AnyHashable: Any]?){
        self.performSegue(withIdentifier: name.string, sender: self)
    }

    func closeScreen(){
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getSharedData() -> SharedData{
        return self.sharedData
    }
    
    func hideBackButton(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
    }
    
    func hideStatusBar(status: Bool){
        self.navigationController?.setNavigationBarHidden(status, animated: false)
    }
    
    func showWallMenu(){
        wallMenu?.showWallMenuOnView(self.view)
    }
    
    func hideWallMenu(){
        wallMenu?.hideWallMenu()
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.hideWallMenu()
    }
}

extension BaseController: WallMenuDelegate{
    func didSelectWallMenuAtIndex(_ index: Int) {
        self.hideWallMenu()
        switch index {
        case 0:
            if  !self.navigationController!.topViewController!.isKind(of: HomeController.self) {
                self.closeScreen()
            }
            break
        case 1:
            if  !self.navigationController!.topViewController!.isKind(of: MyAttendanceController.self) {
                self.openScreen(WithName: .myAttendace, paramters: nil)
            }
            break
            
        case 8:
            self.getSharedData().isLoggedIn = false
            self.openScreen(WithName: .login, paramters: nil)
            break
        default:
            break
        }
    }
}
