//
//  Utils.swift
//  countdown
//
//  Created by evdodima on 14/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import Foundation
import CoreData


var filePath : String {
    let manager = FileManager.default
    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as URL!
    return (url?.appendingPathComponent("events").path)!
}

extension TimeInterval {
    func days() -> Int{
        return Int(self / 86400 )
    }
    func hours() -> Int{
        return Int(self / 3600)
    }
    func minutes() -> Int{
        return Int(self / 60 )
    }
}

extension Date {
    func asString() -> String{
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
    
}
