//
//  imagePickerViewController.swift
//  countdown
//
//  Created by evdodima on 19/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import UIKit

class imagePickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let imagePickerController: UIImagePickerController = UIImagePickerController();

    @IBOutlet weak var imagesTableView: UITableView!
    
    @IBAction func addNewImage(_ sender: Any) {
        imagePickerController.allowsEditing = false;
        imagePickerController.delegate = self;
        imagePickerController.sourceType = .photoLibrary;
        present(imagePickerController, animated: true, completion: nil)
        
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagesTableView.delegate = self
        imagesTableView.dataSource = self
        
        imagesTableView.contentInset = UIEdgeInsetsMake(0, 0, 46, 0)


        // Do any additional setup after loading the view.
    }
    
    
    
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return imageNames.count
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        imagesTableView.deselectRow(at: indexPath, animated: false)
        performSegue(withIdentifier: "imagePicked", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            imageNames.remove(at: indexPath.row);
            imagesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
        }
    }

    
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? newEventVC {
            let row = (sender as! IndexPath).row
            dest.selectedImageName = imageNames[row]
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let cropVC = (storyboard?.instantiateViewController(withIdentifier: "imageCropper"))! as! ImageCropperVC
        picker.dismiss(animated: false, completion: {() -> Void in
            cropVC.pickedImage = info[UIImagePickerControllerOriginalImage] as? UIImage
            self.present(cropVC,
            animated: true,completion: nil)
        })
       
    }
    
    
    
//    func tableView(_ tableView: UITableView, didHighlightRowAt indexPath: IndexPath) {
//        if let cell  = tableView.cellForRow(at: indexPath as IndexPath) as? imageTableViewCell {
//            cell.imageToPickView.alpha = 0.2
//        }
//    }
//    
//    func tableView(_ tableView: UITableView, didUnhighlightRowAt indexPath: IndexPath) {
//        if let cell  = tableView.cellForRow(at: indexPath as IndexPath) as? imageTableViewCell {
//            cell.imageToPickView.alpha = 1
//        }
//    }
    
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        
        let cell:imageTableViewCell = self.imagesTableView.dequeueReusableCell(withIdentifier: "imageCell")! as! imageTableViewCell
        cell.imageToPickView.image = nil
        cell.imageToPickView.image = UIImage(named: imageNames[indexPath.row])
        return cell
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
