//
//  HomeMenuCell.swift
//  SchoolApp
//
//  Created by Prethush on 22/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class HomeMenuCell: UITableViewCell {

    @IBOutlet weak var imgSideIcon: UIImageView!
    @IBOutlet weak var lblListTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setDataForIndex(index: Int){
        switch index {
        case 0:
            lblListTitle.text = "Absence"
            imgSideIcon.image = UIImage(named: "Attendance")
            break
        case 1:
            lblListTitle.text = "Fees"
            imgSideIcon.image = UIImage(named: "fees")
            break
        case 2:
            lblListTitle.text = "Marksheet"
            imgSideIcon.image = UIImage(named: "marklist")
        default:
            break
        }
    }

}
