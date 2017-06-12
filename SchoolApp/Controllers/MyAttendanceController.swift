//
//  MyAttendanceController.swift
//  SchoolApp
//
//  Created by Prethush on 25/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit
import ActionSheetPicker_3_0
import CVCalendar

class MyAttendanceController: UIViewController, MenuViewDelegate {
    @IBOutlet weak var btnBack: UIButton!
    @IBOutlet weak var btnMenu: UIButton!
    @IBOutlet weak var calendarMenu: CVCalendarMenuView!
    @IBOutlet weak var calendarView: CVCalendarView!
    @IBOutlet weak var lblDate: UILabel!
    let homeData = AppDelegate.getAppDelegate().homeData
    @IBOutlet weak var studentName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.showStatusBar(status: true)
        self.showBackButton(status: true)
        self.showMenuButton(status: true)
        
        self.calendarMenu.delegate = self
        self.calendarView.delegate = self
        
        self.lblDate.text = self.calendarView.presentedDate.convertedDate()?.shortString() ?? ""
        
        self.title = "Attendance"
    }
    
    override func backButtonAction(){
        self.performSegue(withIdentifier: "prepareForUnwind", sender: self)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        // Commit frames' updates
        self.calendarMenu.commitMenuViewUpdate()
        self.calendarView.commitCalendarViewUpdate()
    }
    
    @IBAction func btnStudentAction(_ sender: Any) {
        
        ActionSheetStringPicker.show(withTitle: "Select student", rows: self.homeData?.model?.userInfo?.childrenNames(), initialSelection: 0, doneBlock: { (picker, row, name) in
            print("selected \(name ?? "")")
            self.studentName.text = String(describing: name ?? "")
        }, cancel: { (picker) in
            print("picker cancelled")
        }, origin: sender)
    }
}

extension MyAttendanceController: CVCalendarViewDelegate{
    func presentationMode() -> CalendarMode {
        return .monthView
    }
    
    func firstWeekday() -> Weekday {
        return .sunday
    }
    
    func didShowNextMonthView(_ date: Date) {
        lblDate.text = date.shortString()
    }
    
    func didShowPreviousMonthView(_ date: Date) {
        lblDate.text = date.shortString()
    }
}

