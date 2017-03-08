//
//  newEventVC.swift
//  countdown
//
//  Created by evdodima on 12/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import UIKit
import CoreData

class newEventVC: UITableViewController {
        
    let textFieldSectionIndex = 0
    let nameCellIndex = 0
    
    let pickersDateSectionIndex = 1
    let startPickerIndex = 1
    let datePickerCellHeight = 170;
    
    let imageCellHeight = 120
    
    var event: Event? = nil
    var events: [Event]? = nil
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var startLabel: UITextField!
    
    @IBOutlet weak var startPicker: UIDatePicker!
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var selectedImage: UIImage! = sampleImages[Int(arc4random_uniform(UInt32(sampleImages.count)))]
    

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        var event: Event? = nil
        
        if self.event != nil {
            event = self.event
            event!.name = nameField.text!
            event!.date = startPicker.date
            event!.bgImage = selectedImage
        } else {
            event = Event(name:nameField.text!,
                              date:startPicker.date,
                              creationDate: Date(), bgImage : selectedImage)
        }
        saveEvent(event: event!)
        self.performSegue(withIdentifier: "backToEventsVC", sender: event)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        super.prepare(for: segue, sender: sender)
        if let dest = segue.destination as? eventsViewController {
            let event = sender as! Event
            let eventDate = event.date
                        
            if eventDate.timeIntervalSinceNow > 0 {
                dest.tabBar.selectedItem = dest.tabBar.items?[0]
            } else {
                dest.tabBar.selectedItem = dest.tabBar.items?[1]
            }
        }
        
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        startLabel.text = sender.date.asString()
        if self.event != nil {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
       
    }

    @IBAction func nameEditingChanged(_ sender: Any) {
            navigationItem.rightBarButtonItem?.isEnabled = (!nameField.text!.isEmpty)
    }
    
    @IBAction func unwindToEvent(segue: UIStoryboardSegue) {
        if self.event != nil {
            navigationItem.rightBarButtonItem?.isEnabled = true
        }
    }

    func setupDatePickers(){
        if (event != nil) {
            startPicker.date = event!.date
        } else {
            startPicker.date = Date()
        }
        startPicker.setValue(UIColor.white, forKeyPath: "textColor")
    }
    
    func setupLabels(){
        startLabel.text = startPicker.date.asString()
        if (event != nil) {
            nameField.text = event?.name
        }
    }
    
    func setupImageView(){
        if (event != nil) {
            selectedImage = event!.bgImage
        }
        selectedImageView.image = selectedImage
    }
    
    func saveEvent(event : Event){
        
        let notification = UILocalNotification()
        notification.alertBody = "'\(event.name)' is happening now!"
        notification.alertAction = "open"
        notification.fireDate = event.date
        notification.userInfo = ["creationDate": event.creationDate]

        if self.event != nil {
            let ind = events!.index(of: self.event!)!
            removeNotification(forEvent: events![ind])            
        } else {
            events!.append(event)
        }
        UIApplication.shared.scheduleLocalNotification(notification)
        print("added \(UIApplication.shared.scheduledLocalNotifications!.count)")

        NSKeyedArchiver.archiveRootObject(events!, toFile: filePath)
        self.event = nil
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePickers()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        setupLabels()
        setupImageView()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedImageView.image = selectedImage
        
        let bounds = self.navigationController?.navigationBar.bounds as CGRect!
        
        let fullBounds = CGRect(x:0,y:-20, width: bounds!.width, height: 64)
        
        let visualEffectView = UIVisualEffectView(effect: UIBlurEffect(style: .dark))
        visualEffectView.frame = fullBounds
        
        self.navigationController?.navigationBar.setBackgroundImage(#imageLiteral(resourceName: "clear"), for: .default)

        self.navigationController?.navigationBar.addSubview(visualEffectView)
        self.navigationController?.navigationBar.sendSubview(toBack: visualEffectView)
        
        
        let imageView = UIImageView(image: selectedImage)
        imageView.contentMode = .scaleAspectFill
        self.tableView.backgroundView = imageView
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.dark)
        let blurView = UIVisualEffectView(effect: blurEffect)
        
        blurView.frame = imageView.bounds
        imageView.addSubview(blurView)
        
        
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = self.tableView.rowHeight;
        
        if (indexPath.section == pickersDateSectionIndex && indexPath.row == startPickerIndex) {
            height = CGFloat((self.startPicker.isHidden) ? 0 :        CGFloat(self.view.frame.height * 0.27)
);
        }
        
        if  (indexPath.section == 2) {
            height = CGFloat(self.view.frame.height * 0.15 + 20)
        }
        
        return height;

    }
    
    override func tableView(_: UITableView, didSelectRowAt: IndexPath) {
        tableView.deselectRow(at: didSelectRowAt, animated: true)
        
        if ( (didSelectRowAt.row != nameCellIndex) )
            || (didSelectRowAt.section != textFieldSectionIndex)
        {
            hideKeyboard()
        }
        
        if (didSelectRowAt.section == pickersDateSectionIndex){
            if (didSelectRowAt.row == startPickerIndex-1){
                startPicker.isHidden ?
                    showCell(forDatePicker: startPicker):
                    hideCell(forDatePicker: startPicker)
            }
        }

    }
    
    override func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        cell.backgroundColor = UIColor.gray.withAlphaComponent(0.5)
    }
    
    func showCell(forDatePicker: UIDatePicker){
        forDatePicker.isHidden = false
        forDatePicker.alpha = 0.0
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.animate(withDuration: 0.4,
                       animations: { forDatePicker.alpha = 1.0}
                       )
    }
    
    func hideCell(forDatePicker: UIDatePicker){
        forDatePicker.isHidden = true
    
        tableView.beginUpdates()
        tableView.endUpdates()
        UIView.animate(withDuration: 0.25,
                       animations: { forDatePicker.alpha = 0.0}
        )
    }
    
    func keyboardWillShow(){
        hideCell(forDatePicker: startPicker)
    }
    
    func hideKeyboard(){
        nameField.resignFirstResponder()
    }
    

}
