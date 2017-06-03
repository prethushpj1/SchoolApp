//
//  MarksheetTableViewCell.swift
//  SchoolApp
//
//  Created by Prethush on 03/06/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class MarksheetTableViewCell: UITableViewCell {

    @IBOutlet weak var lblSubject: UILabel!
    @IBOutlet weak var lblMark: UILabel!
    @IBOutlet weak var lblResult: UILabel!
    @IBOutlet weak var lblGrade: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        // Configure the view for the selected state
    }
    
    func set(Data mark: ENmark){
        lblSubject.text = mark.subject
        lblMark.text = "\(mark.marksObtained ?? 0.0)"
        lblResult.text = mark.result
        lblGrade.text = mark.grade
    }

}
