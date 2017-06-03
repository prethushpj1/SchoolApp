//
//  BaseController.swift
//  SchoolApp
//
//  Created by Prethush on 20/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import NVActivityIndicatorView
import SideMenu

class BaseController: UIViewController {

    let sharedData = SharedData()
    let apiServices = APIServices()
    var scrollContentView: UIScrollView?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.navigationBar.isTranslucent = false
        self.showStatusBar(status: false)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyBoardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        self.showMenuButton(status: false)
        
        let menuRightNavigationController = UISideMenuNavigationController(rootViewController: WallMenu.shared)
        SideMenuManager.menuRightNavigationController = menuRightNavigationController
        SideMenuManager.menuRightNavigationController?.setNavigationBarHidden(true, animated: false)
        SideMenuManager.menuFadeStatusBar = false
        SideMenuManager.menuPushStyle = .popWhenPossible
        
        WallMenu.shared.dataArray = ["Home", "My Children", "Absence Reports", "Mark Sheets" , "Payments", "Messages" ,"Calendar", "Chat", "Log out"]
        WallMenu.shared.imageNameArray = ["home" , "children", "Attendance", "marklist", "fees", "messages", "calendarLight","chatIcon", "logout"]
        WallMenu.shared.menuTitle = "School Name"
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openScreen(WithName name: ScreenName){
        let sb = UIStoryboard(name: "Main", bundle: nil)
        let vc = sb.instantiateViewController(withIdentifier: name.string)
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    func getSharedData() -> SharedData{
        return self.sharedData
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

extension UIViewController: NVActivityIndicatorViewable{
    
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
    
    func showStatusBar(status: Bool){
        if status {
            self.navigationController?.navigationBar.barTintColor = UIColor(red: 139/255.0, green: 196/255.0, blue: 79/255.0, alpha: 1)
            self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName : UIColor.white]
        }
        self.navigationController?.setNavigationBarHidden(!status, animated: false)
    }
    
    func showBackButton(status: Bool){
        var view = UIView()
        if status {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 20, height: 30))
            btn.addTarget(self, action: #selector(backButtonAction), for: .touchUpInside)
            btn.setBackgroundImage(UIImage(named: "backArrow"), for: .normal)
            view = btn
        }
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    func backButtonAction(){
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func showMenuButton(status: Bool){
        var view = UIView()
        if status {
            let btn = UIButton(frame: CGRect(x: 0, y: 0, width: 30, height: 30))
            btn.addTarget(self, action: #selector(showWallMenu), for: .touchUpInside)
            btn.setBackgroundImage(UIImage(named: "Menu"), for: .normal)
            view = btn
        }
        self.navigationItem.rightBarButtonItem = UIBarButtonItem(customView: view)
    }
    
    func showWallMenu(){
        if self.presentingViewController?.presentedViewController == SideMenuManager.menuRightNavigationController {
            self.dismiss(animated: true, completion: nil)
        }
        else{
            self.present(SideMenuManager.menuRightNavigationController!, animated: true, completion: nil)
        }
    }
}
