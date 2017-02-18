//
//  Event.swift
//  countdown
//
//  Created by evdodima on 17/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import Foundation


class Event : NSObject, NSCoding {
    var name:String
    var date:Date
    var creationDate:Date
    
    init(name:String, date:Date, creationDate:Date){
        self.name = name
        self.date = date
        self.creationDate = creationDate
    }
    
    public func encode(with aCoder: NSCoder){
        aCoder.encode(self.name, forKey: "name")
        aCoder.encode(self.date, forKey:"date")
        aCoder.encode(self.creationDate, forKey:"creationDate")
    }
    
    public required init?(coder aDecoder: NSCoder){
        self.name = aDecoder.decodeObject(forKey: "name") as! String
        self.date = aDecoder.decodeObject(forKey: "date") as! Date
        self.creationDate = aDecoder.decodeObject(forKey: "creationDate") as! Date
    }




}
