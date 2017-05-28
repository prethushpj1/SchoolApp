//
//  MyChildrensListCell.swift
//  SchoolApp
//
//  Created by Prethush on 03/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class MyChildrensListCell: UITableViewCell {

    @IBOutlet weak var imgProfile: UIImageView!
    @IBOutlet weak var lblName: UILabel!
    @IBOutlet weak var lblClass: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func set(Data childrenInfo: EnStudentInfo){
        self.lblName.text = childrenInfo.studentName
        self.lblClass.text = "\(childrenInfo.className ?? "") \(childrenInfo.division ?? "")"
        self.imgProfile.image = UIImage(named: "Student")
    }
}
