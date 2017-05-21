//
//  BaseController.swift
//  SchoolApp
//
//  Created by Prethush on 20/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import NVActivityIndicatorView

protocol BaseDelegate {
    func viewDidResume(parameters: [String: Any])
}

class BaseController: UIViewController, NVActivityIndicatorViewable {

    let sharedData = SharedData()
    var wallMenu: WallMenu?
    let apiServices = APIServices()
    var delegate: BaseDelegate?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wallMenu = WallMenu.getInstance
        wallMenu?.delegate = self
        wallMenu?.dataArray = ["Home", "My Children", "Absence Reports", "Mark Sheets" , "Payments", "Messages" ,"Calendar", "Chat", "Log out"]
        wallMenu?.imageNameArray = ["home" , "children", "Attendance", "marklist", "fees", "messages", "calendarLight","chatIcon", "logout"]
        wallMenu?.title = "School Name"
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.hideStatusBar(status: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openScreen(WithName name: ScreenName,
                    paramters: [AnyHashable: Any]?){
        self.performSegue(withIdentifier: name.string, sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let destination = segue.destination as! BaseController
        destination.delegate = self
    }

    func backButtonAction(){
        self.closeScreen()
    }
    
    @objc func closeScreen(){
        self.closeScreen(parameters: [:])
    }
    @objc func closeScreen(parameters: [String: Any]){
        let _ = self.navigationController?.popViewController(animated: true)
        if let deleg = self.delegate{
            deleg.viewDidResume(parameters: parameters)
        }
    }
    
    func getSharedData() -> SharedData{
        return self.sharedData
    }
    
    func hideBackButton(status: Bool){
        var view = UIView()
        if !status {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
            btn.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
            btn.setBackgroundImage(UIImage(named: "backArrow"), for: .normal)
            view = btn
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    func hideStatusBar(status: Bool){
        if !status {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 139/255.0, green: 196/255.0, blue: 79/255.0, alpha: 1)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        }
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
    
    func getAPIServices() -> APIServices{
        return apiServices
    }
    
    func getAppDelegate() -> AppDelegate{
        return AppDelegate.getAppDelegate()
    }
}

extension BaseController: BaseDelegate{
    func viewDidResume(parameters: [String : Any]) {
        
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
            
            break
            
        case 2:
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

extension UIViewController{
    
    func showAlert(WithTitle title: String?, Message message: String, OKButtonTitle okTitle: String, OKButtonAction: (() -> ())?, CancelButtonTitle cancelTitle: String?, CancelButtonAction: (() -> ())?){
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default, handler: { (action) in
            if let okBlock = OKButtonAction{
                okBlock()
            }
        }))
        
        if let cancel = cancelTitle{
            alert.addAction(UIAlertAction(title: cancel, style: .cancel, handler: { (action) in
                if let cancelBlock = CancelButtonAction{
                    cancelBlock()
                }
            }))
        }
        
        self.present(alert, animated: true, completion: nil)
    }
}
