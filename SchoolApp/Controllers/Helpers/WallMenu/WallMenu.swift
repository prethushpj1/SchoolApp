//
//  WallMenu.swift
//  WallMenuApp
//
//  Created by Prethush on 07/10/16.
//

import UIKit

protocol WallMenuDelegate: NSObjectProtocol {
    
    func didSelectWallMenuAtIndex(_ index: Int)
}

/// WallMenu view
class WallMenu: UIViewController {
    
    @IBOutlet weak var uxTblMenu: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgTitle: UIImageView!
    @IBOutlet weak var btnMenu: UIButton!
    
    fileprivate let wallMenuDuration = 0.4
    fileprivate var parentView: UIViewController?
    internal var dataArray: [String]?
    internal var delegate: WallMenuDelegate?
    internal var imageNameArray: [String]?
    var menuTitle: String?
    
    static let shared = UIStoryboard(name: "WallMenu", bundle: nil).instantiateViewController(withIdentifier: "WallMenu") as! WallMenu
    
    var rootViewController: UIViewController{
        get{
            let navController = (AppDelegate.getAppDelegate().window?.rootViewController)! as! UINavigationController
            
            return navController.topViewController!
        }
    }
    
    override func viewDidLoad() {
        uxTblMenu.delegate = self
        uxTblMenu.dataSource = self
        
        imgTitle.layer.cornerRadius = imgTitle.frame.size.width / 2
        imgTitle.layer.masksToBounds = true
        
        btnMenu.addTarget(self, action: #selector(hideWallMenu), for: .touchUpInside)
        self.lblTitle.text = self.menuTitle
    }

    /**
     call this method to show the wall menu
     
     - parameter view: view in which wallmenu should be displayed
     */
    func showWallMenu(){
        
        self.rootViewController.view.addSubview(self.view)
        var frameRect = self.view.frame
        frameRect.origin.x = self.rootViewController.view.frame.size.width
        self.view.frame = frameRect

        UIView.animate(withDuration: 0.6) {
            frameRect.origin.x = 0
            self.view.frame = frameRect
        }
    }
    
    func hideWallMenu(){
        self.hideWallMenuCompletion(Handler: nil)
    }
    
    func hideWallMenuCompletion(Handler: (() -> ())?){
        UIView.animate(withDuration: 0.6, animations: {
            var frameRect = self.view.frame
            frameRect.origin.x = self.view.frame.size.width
            self.view.frame = frameRect
        }) { (status) in
            self.view.removeFromSuperview()
            Handler?()
        }
    }
}

extension WallMenu: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        self.hideWallMenuCompletion { 
            if let delegate = self.delegate{
                delegate.didSelectWallMenuAtIndex(indexPath.row)
            }
        }
    }
}

extension WallMenu: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if let data =  dataArray{
            return data.count
        }
        
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "wallMenuCell") as? WallMenuCell
        cell!.setTitle(dataArray![indexPath.row])
        
        if let imageArray = imageNameArray, imageArray.count > indexPath.row {
            cell!.setTitleImageFromName(imageArray[indexPath.row])
        }
        
        return cell!
    }
}

extension WallMenu: WallMenuDelegate{
    func didSelectWallMenuAtIndex(_ index: Int) {
        
    }
}

internal class WallMenuCell: UITableViewCell {
    
    @IBOutlet weak var uxLblTitle: UILabel!
    @IBOutlet weak var uxImgTitle: UIImageView!
    
    func setTitle(_ title: String){
        uxLblTitle.text = title
    }
    
    func setTitleImageFromName(_ imageName: String){
        if let image = UIImage(named: imageName) {
            uxImgTitle.image = image
        }
    }
}
