//
//  AttendanceCell.swift
//  SchoolApp
//
//  Created by Prethush on 28/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class AttendanceCell: UITableViewCell {

    @IBOutlet weak var lblAttendanceDate: UILabel!
    @IBOutlet weak var lblFirstHalfPresent: UILabel!
    @IBOutlet weak var lblSecondHalfPresent: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        lblFirstHalfPresent.layer.cornerRadius = 9
        lblFirstHalfPresent.layer.masksToBounds = true
        lblSecondHalfPresent.layer.cornerRadius = 9
        lblSecondHalfPresent.layer.masksToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func firstHalfPresent(status isTrue: Bool){
        if isTrue {
            lblFirstHalfPresent.backgroundColor = UIColor.green
        }
        else{
            lblFirstHalfPresent.backgroundColor = UIColor.red
        }
    }
    
    func secondHalfPresent(status isTrue: Bool){
        if isTrue {
            lblSecondHalfPresent.backgroundColor = UIColor.green
        }
        else{
            lblSecondHalfPresent.backgroundColor = UIColor.red
        }
    }

}
