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
class WallMenu: UIView {
    
    @IBOutlet weak var uxTblMenu: UITableView!
    @IBOutlet weak var lblTitle: UILabel!
    @IBOutlet weak var imgTitle: UIImageView!
    @IBOutlet weak var btnMenu: UIButton!
    
    fileprivate let wallMenuDuration = 0.4
    fileprivate var parentView: UIView?
    internal var dataArray: [String]?
    internal var delegate: WallMenuDelegate?
    internal var imageNameArray: [String]?
    /**
     Overriden method from UIView
     */
    
    override func awakeFromNib() {
        
        uxTblMenu.delegate = self
        uxTblMenu.dataSource = self
        
        self.layer.borderWidth = 1.0
        self.layer.borderColor = UIColor(red: 221/255.0, green: 221/255.0, blue: 221/255.0, alpha: 1).cgColor
        
        imgTitle.layer.cornerRadius = imgTitle.frame.size.width / 2
        imgTitle.layer.masksToBounds = true
        
        btnMenu.addTarget(self, action: #selector(hideWallMenu), for: .touchUpInside)
    }

    /// Call this method to get the object
    class var getInstance: WallMenu{
        
        let obj = Bundle.main.loadNibNamed("WallMenu",
                                                     owner: self,
                                                     options: nil)
        
        
        return obj![0] as! WallMenu
    }

    /**
     call this method to show the wall menu
     
     - parameter view: view in which wallmenu should be displayed
     */
    func showWallMenuOnView(_ view: UIView?){
    
        parentView = view
        
        var frameRect = view!.frame
        frameRect.size.width = view!.frame.size.width * 0.8
        frameRect.origin.x = view!.frame.size.width - frameRect.size.width
        self.frame = frameRect
        
        //Open wall menu
        let transition = CATransition()
        transition.duration = wallMenuDuration
        transition.type = kCATransitionMoveIn
        transition.subtype = kCATransitionFromRight
        
        self.isHidden = true
        view!.addSubview(self)
        self.layer.add(transition, forKey: kCATransition)
        self.isHidden = false
    }
    
    func hideWallMenu(){
        
        var frameRect = self.frame
        frameRect.origin.x = self.frame.size.width
        self.frame = frameRect
        
        //Close wall menu
        let transition = CATransition()
        transition.duration = wallMenuDuration
        transition.type = kCATransitionPush
        transition.subtype = kCATransitionFromLeft
        
        self.layer.add(transition, forKey: kCATransition)
        
        DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + wallMenuDuration, execute: { () -> Void in
            self.removeFromSuperview()
        })

    }
    
    internal var title: String?{
        get{
            return self.lblTitle.text
        }
        set(title){
            self.lblTitle.text = title ?? ""
        }
    }
    
}

extension WallMenu: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let delegate = self.delegate{
            delegate.didSelectWallMenuAtIndex(indexPath.row)
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
        
        var cell = tableView.dequeueReusableCell(withIdentifier: "wallMenu") as? WallMenuCell
        
        if cell == nil {
            
            let obj = Bundle.main.loadNibNamed("WallMenuCell",
                                                         owner: self,
                                                         options: nil)

            
            cell = obj?[0] as? WallMenuCell
        }
        
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
