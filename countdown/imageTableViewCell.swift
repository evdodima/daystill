//
//  imageTableViewCell.swift
//  countdown
//
//  Created by evdodima on 19/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import UIKit

class imageTableViewCell: UITableViewCell {

    @IBOutlet weak var imageToPickView: UIImageView!
        
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
//        if selected {
//            self.alpha = 0.4
//        } else {
//            self.alpha = 1.0
//        }
        // Configure the view for the selected state
    }
}
