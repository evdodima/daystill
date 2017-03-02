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
    var allevents: [Event] = []

    let cellHeight = 100


    
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
    
    @IBAction func unwindToEventsVC(segue: UIStoryboardSegue){
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
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? UINavigationController {
            let editVC = dest.viewControllers.first as! newEventVC
            editVC.events = allevents
            if segue.identifier == "editEvent" {
                if let dest = segue.destination as? UINavigationController {
                     let editVC = dest.viewControllers.first as! newEventVC
                    let event = (sender as! EventTableViewCell).event
                    editVC.event = event
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat{
        return CGFloat(cellHeight)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            removeEvent(index: allevents.index(of:events[indexPath.row])!)
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
            allevents = newevents
        } else {
            NSKeyedArchiver.archiveRootObject(allevents, toFile: filePath)
            return
        }
        
        if (tabBar.selectedItem ==  tabBar.items?[0]) {
            events = allevents.filter({ (Event) -> Bool in
                return Event.date > Date()})
            events = events.sorted(by: { $0.date < $1.date })
        } else {
            events = allevents.filter({ (Event) -> Bool in
                return Event.date <= Date()})
            events = events.sorted(by: { $0.date > $1.date })
        }
    }
    
    func removeEvent(index:Int){
            allevents.remove(at: index)
            NSKeyedArchiver.archiveRootObject(allevents, toFile: filePath)
        loadEvents()
    }
}


    
    
    
    
    
    
    
    

