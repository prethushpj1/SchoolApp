//
//  HomeActivityCell.swift
//  SchoolApp
//
//  Created by Prethush on 22/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class HomeActivityCell: UITableViewCell {

    @IBOutlet weak var btnLeftClick: UIButton!
    @IBOutlet weak var btnRightClick: UIButton!
    @IBOutlet weak var lblActivityDate: UILabel!
    @IBOutlet weak var lblActivitytime: UILabel!
    @IBOutlet weak var lblActivityDescription: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
