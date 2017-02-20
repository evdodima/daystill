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
    let datePickerCellHeight = 216;
    
    let imageCellHeight = 100
    
    @IBOutlet weak var nameField: UITextField!
    
    @IBOutlet weak var startLabel: UITextField!
    
    @IBOutlet weak var startPicker: UIDatePicker!
    
    @IBOutlet weak var selectedImageView: UIImageView!
    
    var selectedImageName: String = "1"
    

    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func save(_ sender: Any) {
        let event = Event(name:nameField.text!,
                          date:startPicker.date,
                          creationDate: Date())
        event.imageName = selectedImageName
        saveEvent(event: event)
    }
    
    @IBAction func datePickerValueChanged(_ sender: UIDatePicker) {
        startLabel.text = sender.date.asString()
       
    }

    @IBAction func nameEditingChanged(_ sender: Any) {
            navigationItem.rightBarButtonItem?.isEnabled = (!nameField.text!.isEmpty)
    }
    
    
    @IBAction func unwindToEvent(segue: UIStoryboardSegue) {}

    
    
    func setupDatePickers(){
        startPicker.date = Date()
    }
    
    func setupLabels(){
        startLabel.text = startPicker.date.asString()
    }
    
    func saveEvent(event : Event){
        guard var events = NSKeyedUnarchiver.unarchiveObject(withFile: filePath) as? [Event] else {
            print("file not found")
            return
        }
        events.append(event)
        NSKeyedArchiver.archiveRootObject(events, toFile: filePath)
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePickers()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        setupLabels()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        hideKeyboard()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        selectedImageView.image = UIImage(named: selectedImageName)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = self.tableView.rowHeight;
        
        if (indexPath.section == pickersDateSectionIndex && indexPath.row == startPickerIndex) {
            height = CGFloat((self.startPicker.isHidden) ? 0 : datePickerCellHeight);
        }
        
        if  (indexPath.section == 2) {
            height = CGFloat(imageCellHeight)
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
