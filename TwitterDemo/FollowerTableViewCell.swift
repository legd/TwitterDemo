//
//  FollowerTableViewCell.swift
//  TwitterDemo
//
//  Created by Luis Guzman on 1/30/17.
//  Copyright © 2017 Luis Guzman. All rights reserved.
//

import UIKit

class FollowerTableViewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var name : UILabel!
    @IBOutlet weak var screenName : UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
