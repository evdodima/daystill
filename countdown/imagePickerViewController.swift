//
//  imagePickerViewController.swift
//  countdown
//
//  Created by evdodima on 19/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import UIKit
import Photos

class imagePickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource {
    
    let imagePickerController: UIImagePickerController = UIImagePickerController();

    @IBOutlet weak var imagesTableView: UITableView!
    
    @IBOutlet weak var addFromLibrary: UIButton!
    
    var pickedImage: UIImage? = nil
    
    
    @IBAction func addNewImage(_ sender: Any) {
        PHPhotoLibrary.requestAuthorization { status in
            self.imagePickerController.allowsEditing = false;
            self.imagePickerController.delegate = self;
            self.imagePickerController.sourceType = .photoLibrary;
            self.present(self.imagePickerController, animated: true, completion: nil)
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        imagesTableView.delegate = self
        imagesTableView.dataSource = self
        
        imagesTableView.contentInset = UIEdgeInsetsMake(-1, 0, 11, 0)


        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
//            switch PHPhotoLibrary.authorizationStatus() {
//            case .denied,.restricted:
//                self.addFromLibrary.isEnabled = false
//                break
//            default:
//                self.addFromLibrary.isEnabled = true
//                break
//            }
    }
    
    public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if userImages.isEmpty {
            return sampleImages.count
        } else {
            return section == 0 ? userImages.count : sampleImages.count
        }
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return userImages.isEmpty ? 1 : 2
    }
    
    public func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        imagesTableView.deselectRow(at: indexPath, animated: false)
        if indexPath.section == 0 && tableView.numberOfSections == 2 {
            self.pickedImage = userImages[indexPath.row]
        } else {
            self.pickedImage = sampleImages[indexPath.row]
        }
        performSegue(withIdentifier: "imagePicked", sender: indexPath)
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return indexPath.section == 0 && tableView.numberOfSections == 2
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCellEditingStyle.delete) {
            userImages.remove(at: indexPath.row)
            tableView.beginUpdates()
            if userImages.isEmpty {
                var indexSet = IndexSet()
                indexSet.insert(indexPath.section)
                tableView.deleteSections(indexSet, with: .automatic)
            }
            imagesTableView.deleteRows(at: [indexPath], with: UITableViewRowAnimation.automatic)
            tableView.endUpdates()
        }
    }
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if userImages.isEmpty {
            return nil
        }
        return section == 0 ? "Your images" : "Sample images"
    }
    
    public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell{
        let cell:imageTableViewCell = self.imagesTableView.dequeueReusableCell(withIdentifier: "imageCell")! as! imageTableViewCell
        
        if indexPath.section == 0 && tableView.numberOfSections == 2 {
            cell.update(withImage: userImages[indexPath.row])
            
        } else {
            cell.update(withImage: sampleImages[indexPath.row])
        }
        return cell
    }
    
//    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if userImages.isEmpty {
            return 1
        }
        return 32
    }
    
    func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header = view as! UITableViewHeaderFooterView
        header.textLabel?.textColor = textColor
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let dest = segue.destination as? newEventVC {
            dest.selectedImage = pickedImage
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let pickedImage : UIImage = (info[UIImagePickerControllerOriginalImage] as? UIImage)!
        
        picker.dismiss(animated: false, completion: { () -> Void in
            
            var imageCropVC : RSKImageCropViewController!
            
            imageCropVC = RSKImageCropViewController(image: pickedImage, cropMode: RSKImageCropMode.custom)
            
            imageCropVC.delegate = self
            imageCropVC.dataSource = self
            self.present(imageCropVC, animated: true, completion: nil)
            
        })
    }
    
    func imageCropViewControllerDidCancelCrop(_ controller: RSKImageCropViewController) {
        controller.dismiss(animated: true, completion: nil)
    }
    
    func imageCropViewController(_ controller: RSKImageCropViewController, didCropImage croppedImage: UIImage, usingCropRect cropRect: CGRect) {
        self.pickedImage = croppedImage
        userImages.insert(croppedImage, at: 0)
        performSegue(withIdentifier: "imagePicked", sender: self)

    }
    
    func imageCropViewControllerCustomMaskRect(_ controller: RSKImageCropViewController) -> CGRect {
        var maskRect : CGRect
        
        let maskHeight = CGFloat(120.0)
        
        let viewWidth = controller.view.frame.width
        let viewHeight = controller.view.frame.height
        
        maskRect = CGRect(
            x:0,
            y:(viewHeight-maskHeight) * 0.5,
            width: viewWidth,
            height: maskHeight)
        return maskRect
    }
    
    func imageCropViewControllerCustomMaskPath(_ controller: RSKImageCropViewController) -> UIBezierPath {
        let rect = controller.maskRect;
        return UIBezierPath(rect: rect)
    }
    
    func imageCropViewControllerCustomMovementRect(_ controller: RSKImageCropViewController) -> CGRect {
        return controller.maskRect
    }
    

    
    
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }

}
