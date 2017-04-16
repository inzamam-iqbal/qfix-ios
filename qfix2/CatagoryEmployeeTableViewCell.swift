//
//  CatagoryEmployeeTableViewCell.swift
//  qfix2
//
//  Created by Ismath on 4/13/17.
//  Copyright © 2017 qfix. All rights reserved.
//

import UIKit

class CatagoryEmployeeTableViewCell: UITableViewCell {

    @IBOutlet weak var catagoryEmployeeCellName: UILabel!
    
    @IBOutlet weak var homeServiceImage: UIImageView!
    @IBOutlet weak var ageTxt: UILabel!
    
    @IBOutlet weak var statusTxt: UILabel!
    @IBOutlet weak var distanceTxt: UILabel!
    @IBOutlet weak var nameTxt: UILabel!
    @IBOutlet weak var catagoryEmployeeCellImage: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        catagoryEmployeeCellImage.layer.cornerRadius = catagoryEmployeeCellImage.frame.width/2
        catagoryEmployeeCellImage.clipsToBounds = true
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
