//
//  PersonCell.swift
//  CFClassRoster
//
//  Created by Joey Nessif on 6/24/15.
//  Copyright (c) 2015 Joey Nessif. All rights reserved.
//

import UIKit

class PersonCell: UITableViewCell {


  @IBOutlet weak var customImage: UIImageView!
  
  @IBOutlet weak var firstNameLabel: UILabel!
  
  @IBOutlet weak var lastNameLabel: UILabel!
  
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
