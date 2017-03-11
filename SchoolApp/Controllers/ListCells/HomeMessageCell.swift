//
//  HomeMessageCell.swift
//  SchoolApp
//
//  Created by Prethush on 23/02/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class HomeMessageCell: UITableViewCell {

    @IBOutlet weak var lblMessageDescription: UILabel!
    @IBOutlet weak var lblMessageDate: UILabel!
    @IBOutlet weak var lblTeacherName: UILabel!
    @IBOutlet weak var lblSubjectName: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
