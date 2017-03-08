//
//  Utils.swift
//  countdown
//
//  Created by evdodima on 14/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import Foundation
import CoreData
import UIKit


let defaults = UserDefaults.standard
var imageNames:[String] = ["1","christmas","3","4","2","lights","5","6","7","9","10","11"]
var sampleImages:[UIImage] = {
    var result:[UIImage] = []
    for name in imageNames {
        result.append(UIImage(named: name)!)
    }
    return result
}()
var userImages: [UIImage] = [] {
    didSet {
        NSKeyedArchiver.archiveRootObject(userImages, toFile: imagesFilePath)
    }
}

let textColor = UIColor(red:0.60, green:0.91, blue:1.00, alpha:1.0)


var filePath : String {
    let manager = FileManager.default
    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as URL!
    return (url?.appendingPathComponent("events").path)!
}

var imagesFilePath : String {
    let manager = FileManager.default
    let url = manager.urls(for: .documentDirectory, in: .userDomainMask).first! as URL!
    return (url?.appendingPathComponent("userImages").path)!
}

func removeNotification(forEvent event: Event){
    guard (UIApplication.shared.scheduledLocalNotifications) != nil else {
        return
    }
    
    let notifications = UIApplication.shared.scheduledLocalNotifications!
    
    for n in notifications {
        if ((n.userInfo!["creationDate"] as! Date).compare(event.creationDate).rawValue == 0) {
            UIApplication.shared.cancelLocalNotification(n)
            print("canceled \(UIApplication.shared.scheduledLocalNotifications!.count)")
            return
        }
    }
}

extension UIButton {
    func setBackgroundColor(color: UIColor, forState: UIControlState) {
        UIGraphicsBeginImageContext(CGSize(width: 1, height: 1))
        UIGraphicsGetCurrentContext()!.setFillColor(color.cgColor)
        UIGraphicsGetCurrentContext()!.fill(CGRect(x: 0, y: 0, width: 1, height: 1))
        let colorImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        self.setBackgroundImage(colorImage, for: forState)
    }
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
    func seconds() -> Int{
        return Int(self)
    }

}

extension Date {
    func asString() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .medium
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: self)
    }
    
}
