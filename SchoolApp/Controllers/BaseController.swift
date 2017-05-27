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
    var scrollContentView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        wallMenu = WallMenu.shared
        wallMenu?.delegate = self
        wallMenu?.dataArray = ["Home", "My Children", "Absence Reports", "Mark Sheets" , "Payments", "Messages" ,"Calendar", "Chat", "Log out"]
        wallMenu?.imageNameArray = ["home" , "children", "Attendance", "marklist", "fees", "messages", "calendarLight","chatIcon", "logout"]
        wallMenu?.menuTitle = "School Name"
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.hideStatusBar(status: true)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.hideMenuButton(status: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openScreen(AsRoot name: ScreenName){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: name.string)
        let navController = UINavigationController(rootViewController: vc)
        navController.navigationBar.isTranslucent = true
        UIApplication.shared.keyWindow?.rootViewController = navigationController
    }
    
    func openScreen(WithName name: ScreenName){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: name.string)
        //self.performSegue(withIdentifier: name.string, sender: self)
        self.navigationController?.pushViewController(vc, animated: true)
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
        self.callViewDidResume(parameters: parameters)
    }
    
    @objc func closeScreenToDashboard(parameters: [String: Any]){
        let _ = self.navigationController?.popToRootViewController(animated: true)
        self.callViewDidResume(parameters: parameters)
    }
    
    func callViewDidResume(parameters: [String: Any]){
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
    
    func hideMenuButton(status: Bool){
        var view = UIView()
        if !status {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
            btn.addTarget(self, action: #selector(showWallMenu), for: .touchUpInside)
            btn.setBackgroundImage(UIImage(named: "Menu"), for: .normal)
            view = btn
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    func showWallMenu(){
        wallMenu?.showWallMenu()
    }
    
    func hideWallMenu(){
        wallMenu?.hideWallMenu()
    }
    
    func getAPIServices() -> APIServices{
        return apiServices
    }
    
    func getAppDelegate() -> AppDelegate{
        return AppDelegate.getAppDelegate()
    }
    
    // MARK: - Keyboard management
    func keyBoardWillShow(_ notification: Notification) {
        
    }

    func keyboardWillHide(){
        let contentInsets = UIEdgeInsets.zero
        self.scrollContentView?.contentInset = contentInsets
        self.scrollContentView?.scrollIndicatorInsets = contentInsets
    }
}

extension BaseController: BaseDelegate{
    func viewDidResume(parameters: [String : Any]) {
//        let screenName = parameters["openScreen"]
//        if let screen = screenName {
//            
//        }
    }
}

extension BaseController: WallMenuDelegate{
    func didSelectWallMenuAtIndex(_ index: Int) {
        switch index {
        case 0:
            if  !self.navigationController!.topViewController!.isKind(of: HomeController.self) {
                self.closeScreenToDashboard(parameters: [:])
            }
            break
        case 1:
            //if  !self.navigationController!.topViewController!.isKind(of: MyChildrenListController.self) {
                 self.openScreen(WithName: .myChildrenList)
            //}
            break
            
        case 2:
            //if  !self.navigationController!.topViewController!.isKind(of: MyAttendanceController.self) {
                self.openScreen(WithName: .myAttendace)
            //}
            break
            
        case 8:
            self.getSharedData().isLoggedIn = false
            self.openScreen(WithName: .login)
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
