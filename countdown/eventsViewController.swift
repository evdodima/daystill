//
//  TableViewController.swift
//  countdown
//
//  Created by evdodima on 11/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import UIKit

class eventsViewController:  UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var table: UITableView!
    
    var items: [String] = ["We", "Heart", "Swift"]


    @IBAction func addNewEvent(_ sender: Any) {
        performSegue(withIdentifier: "newEvent", sender: self)
    }

    override func viewDidLoad() {
        super.viewDidLoad()
         self.table.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }


     func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

     func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.items.count;
    }

    
     func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell:UITableViewCell = self.table.dequeueReusableCell(withIdentifier: "cell")! as UITableViewCell
        
        cell.textLabel?.text = self.items[indexPath.row]
        
        return cell    }
    
    
    override var prefersStatusBarHidden: Bool {
        return true
    }


}
