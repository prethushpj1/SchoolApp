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
    override func viewDidLoad() {
        super.viewDidLoad()

        self.getSharedData().isLoggedIn = true
        // Do any additional setup after loading the view.
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func openScreen(WithName name: ScreenName,
                    paramters: [AnyHashable: Any]?,
                    completion: (() -> Void)?){
//        self.openController(self.getControllerWithStoryboardID(name.string), animated: true, paramters: paramters, completion: completion)
        self.performSegue(withIdentifier: name.string, sender: self)
    }
    
    fileprivate func openController(_ controller: UIViewController,
                        animated: Bool,
                        paramters: [AnyHashable: Any]?,
                        completion: (() -> Void)?){
        controller.modalPresentationStyle = .overCurrentContext
        self.presentControllerWithTransition(controller)
    }
    
    fileprivate func getControllerWithStoryboardID(_ id: String) -> BaseController{
        return (UIStoryboard(name: "Main", bundle: Bundle(for: BaseController.self))).instantiateViewController(withIdentifier: id) as! BaseController
    }
    
    fileprivate func presentControllerWithTransition(_ controller: UIViewController){
        
        let transition = CATransition()
        transition.duration = 0.3
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        controller.view.isHidden = true
        self.present(controller, animated: false) {
            controller.view.isHidden = false
            controller.view.layer.add(transition,
                                      forKey: kCATransition)
        }
    }

    func closeScreen(){
        
//        let transition = CATransition()
//        transition.duration = 0.3
//        transition.type = kCATransitionReveal
//        transition.subtype = kCATransitionFromRight
//        self.view.window?.layer.add(transition, forKey: kCATransition)
//        self.view.isHidden = true
//        self.dismiss(animated: true, completion: completion)
        let _ = self.navigationController?.popViewController(animated: true)
    }
    
    func getSharedData() -> SharedData{
        return self.sharedData
    }
    
    func hideBackButton(){
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: UIView())
    }
}
