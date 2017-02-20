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
    
    @IBOutlet weak var backgroundImage: UIImageView!
    var event: Event? = nil
    
    func updateCell(withEvent: Event){
        self.event = withEvent
        backgroundImage.image = nil
        backgroundImage.image = UIImage(named: withEvent.imageName)
        var interval = withEvent.date.timeIntervalSinceNow.days()
        var currency = (interval == 1) ? "Day" : "Days"
        if interval == 0 {
            interval = withEvent.date.timeIntervalSinceNow.hours()
            currency = (interval == 1) ? "Hour" : "Hours"

            if interval == 0 {
                interval = withEvent.date.timeIntervalSinceNow.minutes()
                currency = (interval == 1) ? "Minute" : "Minutes"
            }
        }
        interval = abs(interval)
        
        if withEvent.date > Date() {
            counterTextLabel.text = currency + " untill"
        } else {
            counterTextLabel.text = currency + " since"
        }
        counterLabel.text = String(interval)
        eventNameLabel.text = withEvent.name
        eventDateLabel.text = withEvent.date.asString()
    }
}
