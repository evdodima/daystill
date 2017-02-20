//
//  TableViewController.swift
//  countdown
//
//  Created by evdodima on 11/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//


import UIKit
import CoreData

class eventsViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource, UITabBarDelegate{
    
    @IBOutlet weak var table: UITableView!

    @IBOutlet weak var tabBar: UITabBar!
    
    var events: [Event] = []

    let cellHeight = 86


    
    override func viewWillAppear(_ animated: Bool) {
        loadEvents()
        table.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
        table.contentInset = UIEdgeInsetsMake(50, 0, 50, 0)
        table.tableFooterView = UIView()
        
        tabBar.selectedItem =  tabBar.items?[0]
        tabBar.delegate = self
    
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

//MARK: - Table
     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.events.count;
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:EventTableViewCell = self.table.dequeueReusableCell(withIdentifier: "eventCell")! as! EventTableViewCell
        
        cell.updateCell(withEvent: events[indexPath.row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            removeEvent(index: indexPath.row)
            table.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }
    //MARK: tabBar
    func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        loadEvents()
        table.reloadData()
    }
    
//MARK: helpers
    func loadEvents(){
        if let newevents =
            (NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
            as? [Event]) {
            events = newevents
        } else {
            NSKeyedArchiver.archiveRootObject(events, toFile: filePath)
        }
        
        if (tabBar.selectedItem ==  tabBar.items?[0]) {
            events = events.filter({ (Event) -> Bool in
                return Event.date > Date()})
            events = events.sorted(by: { $0.date < $1.date })
            
        } else {
            events = events.filter({ (Event) -> Bool in
                return Event.date < Date()})
            events = events.sorted(by: { $0.date > $1.date })
        }
    }
    
    func removeEvent(index:Int){
        if var newevents =
            (NSKeyedUnarchiver.unarchiveObject(withFile: filePath)
                as? [Event]) {
            newevents.remove(at: index)
            NSKeyedArchiver.archiveRootObject(newevents, toFile: filePath)

        }
        loadEvents()
    }
}


    
    
    
    
    
    
    
    

