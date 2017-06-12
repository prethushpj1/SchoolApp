//
//  PaymentCell.swift
//  SchoolApp
//
//  Created by Prethush on 01/03/17.
//  Copyright © 2017 AITS Inc. All rights reserved.
//

import UIKit

class PaymentCell: UITableViewCell {
    @IBOutlet weak var lblDate: UILabel!
    @IBOutlet weak var lblFeeName: UILabel!
    @IBOutlet weak var lblFee: UILabel!
    @IBOutlet weak var lblFine: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        if selected {
            self.accessoryType = .checkmark
        }
        else{
            self.accessoryType = .none
        }
        let selectionView = UIView()
        selectionView.backgroundColor = UIColor.white
        self.selectedBackgroundView = selectionView
        // Configure the view for the selected state
    }

    func set(Data fee:ENFee){
        self.lblDate.text = (fee.lastDate ?? "").toDateWithoutTime()
        self.lblFeeName.text = fee.feeName
        self.lblFee.text = "\(fee.amount ?? 0)"
        self.lblFine.text = "\(fee.fine ?? 0)"
    }
}
