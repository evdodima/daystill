//
//  newEventVC.swift
//  countdown
//
//  Created by evdodima on 12/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import UIKit

class newEventVC: UITableViewController {
        
    let textFieldSectionIndex = 0
    let nameCellIndex = 0
    let descCellIndex = 1
    
    let pickersDateSectionIndex = 1
    let startPickerIndex = 1
    let endPickerIndex = 3
    let datePickerCellHeight = 216;


    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var descriptionField: UITextField!
    
    @IBOutlet weak var startLabel: UITextField!
    @IBOutlet weak var endLabel: UITextField!
    
    @IBOutlet weak var startPicker: UIDatePicker!
    @IBOutlet weak var endPicker: UIDatePicker!
    
    @IBAction func cancel(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    

    func setupDatePickers(){
        startPicker.isHidden = true
        endPicker.isHidden = true
        
        startPicker.tag = 0
        endPicker.tag = 1
        
        startPicker.date = Date()
        endPicker.minimumDate = startPicker.date
    }
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupDatePickers()
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)


        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        var height = self.tableView.rowHeight;
        // Set height = 0 for hidden date pickers
        if (indexPath.section == pickersDateSectionIndex && indexPath.row == startPickerIndex) {
            height = CGFloat((self.startPicker.isHidden) ? 0 : datePickerCellHeight);
        } else if (indexPath.section == pickersDateSectionIndex && indexPath.row == endPickerIndex) {
            height =  CGFloat((self.endPicker.isHidden ) ? 0 : datePickerCellHeight);
        }
        return height;

    }
    
    override func tableView(_: UITableView, didSelectRowAt: IndexPath) {
        tableView.deselectRow(at: didSelectRowAt, animated: true)
        
        if ( (didSelectRowAt.row != nameCellIndex) || (didSelectRowAt.row != descCellIndex))
            || (didSelectRowAt.section != textFieldSectionIndex)
        {
            nameField.resignFirstResponder()
            descriptionField.resignFirstResponder()
        }
        
        if (didSelectRowAt.section == pickersDateSectionIndex){
            if (didSelectRowAt.row == startPickerIndex-1){
                startPicker.isHidden ?
                    showCell(forDatePicker: startPicker):
                    hideCell(forDatePicker: startPicker)
                hideCell(forDatePicker: endPicker)
            }
            else if (didSelectRowAt.row == endPickerIndex-1){
                endPicker.isHidden ?
                    showCell(forDatePicker: endPicker):
                    hideCell(forDatePicker: endPicker)
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
        hideCell (forDatePicker: endPicker)
    }


}
