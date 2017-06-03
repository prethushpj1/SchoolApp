//
//  WallMenu.swift
//  WallMenuApp
//
//  Created by Prethush on 07/10/16.
//

import UIKit
import SideMenu

/// WallMenu view
class WallMenu: UIViewController {
    
    @IBOutlet weak var uxTblMenu: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgTitle: UIImageView!
    
    fileprivate let wallMenuDuration = 0.4
    fileprivate var parentView: UIViewController?
    internal var dataArray: [String]?
    internal var imageNameArray: [String]?
    var menuTitle: String?
    
    static let shared = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "WallMenu") as! WallMenu
    
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
        
        self.lblTitle.text = self.menuTitle
    }
}

extension WallMenu: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        switch indexPath.row {
        case 0:
            self.performSegue(withIdentifier: ScreenName.dashboard.string, sender: self)
            break
        case 1:
            self.performSegue(withIdentifier: ScreenName.myChildrenList.string, sender: self)
            break
        case 2:
            self.performSegue(withIdentifier: ScreenName.myAttendace.string, sender: self)
            break
        case 3:
            self.performSegue(withIdentifier: ScreenName.marksheet.string, sender: self)
            break
        default:
            break
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
