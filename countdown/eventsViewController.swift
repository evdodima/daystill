//
//  TableViewController.swift
//  countdown
//
//  Created by evdodima on 11/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//


import UIKit
import CoreData

class eventsViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!

    
    var events: [Event] = [Event(name:"first event",
                                    date: Date().addingTimeInterval(100000),
                                    creationDate: Date()),
                              Event(name:"second event",
                                    date:Date().addingTimeInterval(200000),
                                    creationDate: Date()),
                              Event(name:"third event",
                                    date:Date().addingTimeInterval(200000),
                                    creationDate: Date())
                            ]

    let cellHeight = 86


    
    override func viewWillAppear(_ animated: Bool) {
        loadEvents()
        table.reloadData()
    }


    override func viewDidLoad() {
        super.viewDidLoad()
         table.contentInset = UIEdgeInsetsMake(50, 0, 0, 0)
        table.tableFooterView = UIView()

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
    
    
    override var prefersStatusBarHidden: Bool {
        return true
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
    }
}

    
    
    
    
    
    
    
    
    

