//
//  HomeController.swift
//  SchoolApp
//
//  Created by Prethush on 19/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class HomeController: BaseController {
    
    enum ListType {
        case events
        case activities
    }
    
    @IBOutlet weak var tblHomeMenu: UITableView!
    @IBOutlet weak var tblHomeActivity: UITableView!
    @IBOutlet weak var vwHeader: UIView!
    @IBOutlet weak var imgHeader: UIImageView!
    @IBOutlet weak var lblSchoolName: UILabel!
    @IBOutlet weak var lblSchoolLocation: UILabel!
    @IBOutlet weak var btnMenu: UIButton!
    
    @IBOutlet weak var btnAnnouncements: UIButton!
    @IBOutlet weak var btnSchoolEvents: UIButton!
    
    var homeListType: ListType = .activities
    var eventsList: [EnEvent]?
    var announcementsList: [EnEvent]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        let loggedIn = self.getSharedData().isLoggedIn
        if loggedIn == false {
            self.openScreen(WithName: .login, paramters: nil)
        }
        else{
            self.getAPIServices().loginWith(userName: self.getSharedData().username, password: self.getSharedData().password) { (response, error) in
                if (error == nil) {
                    self.eventsList = response?.getHomeDataList().events
                    self.announcementsList = response?.getHomeDataList().announcements
                    self.btnAnnouncementsAction("")
                }
                else{
                    self.openScreen(WithName: .login, paramters: nil)
                }
            }
        }
        
        self.tblHomeMenu.delegate = self
        self.tblHomeMenu.dataSource = self
        
        self.tblHomeActivity.dataSource = self
        self.tblHomeActivity.delegate = self
        
        self.imgHeader.layer.cornerRadius = self.imgHeader.frame.size.width / 2
        self.imgHeader.layer.masksToBounds = true
        
        self.btnMenu.addTarget(self, action: #selector(menuButtonPressed), for: .touchUpInside)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func menuButtonPressed(){
        self.showWallMenu()
    }

    @IBAction func btnAnnouncementsAction(_ sender: Any) {
        btnSchoolEvents.setTitleColor(UIColor.darkGray, for: .normal)
        btnAnnouncements.setTitleColor(UIColor.white, for: .normal)
        self.homeListType = .activities
        
        self.tblHomeActivity.reloadData()
    }
    
    @IBAction func btnSchoolEventsAction(_ sender: Any) {
        btnSchoolEvents.setTitleColor(UIColor.white, for: .normal)
        btnAnnouncements.setTitleColor(UIColor.darkGray, for: .normal)
        self.homeListType = .events
        
        self.tblHomeActivity.reloadData()
    }
    
    override func viewDidResume(parameters: [String : Any]) {
        super.viewDidResume(parameters: parameters)
        
        let loggedIn = parameters["isLoggedIn"] as? Bool
        if loggedIn == true {
            if let homeData = self.getAppDelegate().homeData{
                self.eventsList = homeData.getHomeDataList().events
                self.announcementsList = homeData.getHomeDataList().announcements
                self.btnAnnouncementsAction("")
            }
        }
    }
}

extension HomeController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if tableView == tblHomeMenu{
            return 44.0
        }
        else{
            return 85.0
        }
    }
}

extension HomeController: UITableViewDataSource{
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if tableView == tblHomeMenu{
            let homeMenuCell = tableView.dequeueReusableCell(withIdentifier: "homeMenuCell", for: indexPath) as! HomeMenuCell
            homeMenuCell.setDataForIndex(index: indexPath.row)
            return homeMenuCell
        }
        else{
            switch self.homeListType {
            case .activities:
                let homeActivityCell = tableView.dequeueReusableCell(withIdentifier: "homeMessageCell", for: indexPath) as! HomeMessageCell
                if let announcement = self.announcementsList {
                     homeActivityCell.set(Data: announcement[indexPath.row])
                }
                return homeActivityCell
            case .events:
                let homeEventsCell = tableView.dequeueReusableCell(withIdentifier: "homeActivityCell", for: indexPath) as! HomeActivityCell
                if let eventList = self.eventsList{
                    homeEventsCell.set(Data: eventList[indexPath.row])
                }
                return homeEventsCell
            }
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if tableView == tblHomeMenu{
            return 3
        }
        else{
            switch self.homeListType {
            case .activities:
                return self.announcementsList?.count ?? 0
            case .events:
                return self.eventsList?.count ?? 0
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if tableView == tblHomeMenu {
            switch indexPath.row {
            case 0:
                self.openScreen(WithName: .myAttendace, paramters: nil)
                break
            default:
                break
            }
        }
    }
}
