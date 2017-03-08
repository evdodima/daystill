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
    var timer: Timer? = nil
    
    func updateCell(withEvent: Event){
        self.event = withEvent
        backgroundImage.image = nil
        backgroundImage.image = withEvent.bgImage
        updateLabels()
        
        if timer == nil {
           timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.updateLabels), userInfo: nil, repeats: true)
            timer!.fire()
        }
        
    }
    
    func updateLabels(){
        var interval = event!.date.timeIntervalSinceNow.days()
        var currency = (interval == 1) ? "Day" : "Days"
        if interval == 0 {
            interval = event!.date.timeIntervalSinceNow.hours()
            currency = (interval == 1) ? "Hour" : "Hours"
            if interval == 0 {
                interval = event!.date.timeIntervalSinceNow.minutes()
                currency = (interval == 1) ? "Minute" : "Minutes"
                if interval == 0 {
                    interval = event!.date.timeIntervalSinceNow.seconds()
                    currency = (interval == 1) ? "Second" : "Seconds"
                }
                
            }
        }
        interval = abs(interval)
        
        if event!.date > Date() {
            counterTextLabel.text = currency + " untill"
        } else {
            counterTextLabel.text = currency + " since"
        }
        counterLabel.text = String(interval)
        eventNameLabel.text = event!.name
        eventDateLabel.text = event!.date.asString()
    }
}
