//
//  AttendanceCell.swift
//  MyExD
//
//  Created by Ahmed on 13/01/2022.
//

import UIKit

class AttendanceCell: UITableViewCell {

    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var timeOutLbl: UILabel!
    @IBOutlet weak var timeInLbl: UILabel!
    @IBOutlet weak var dateLbl: UILabel!
    @IBOutlet weak var dayLbl: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
