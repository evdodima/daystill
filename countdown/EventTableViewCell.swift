//
//  EventTableViewCell.swift
//  countdown
//
//  Created by evdodima on 14/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import UIKit

class EventTableViewCell: UITableViewCell {

    @IBOutlet weak var counterLabel: UILabel!
    @IBOutlet weak var counterTextLabel: UILabel!
    @IBOutlet weak var eventNameLabel: UILabel!
    @IBOutlet weak var eventDateLabel: UILabel!
    
    
    func updateCell(withEvent: Event){
        let timeUntill = withEvent.date.timeIntervalSince(Date()).days()
        counterLabel.text = String(timeUntill)
        counterTextLabel.text = "Days untill"
        eventNameLabel.text = withEvent.name
        eventDateLabel.text = withEvent.date.asString()
    }
}
