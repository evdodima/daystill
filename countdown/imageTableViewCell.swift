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
    func update(withImage: UIImage){
        self.imageToPickView.image = nil
        self.imageToPickView.image = withImage
    }
}
