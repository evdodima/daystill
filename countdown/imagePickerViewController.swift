//
//  imagePickerViewController.swift
//  countdown
//
//  Created by evdodima on 19/02/2017.
//  Copyright © 2017 Evdodima. All rights reserved.
//

import UIKit

class imagePickerViewController: UIViewController, UITableViewDelegate, UITableViewDataSource,UIImagePickerControllerDelegate, UINavigationControllerDelegate, RSKImageCropViewControllerDelegate,RSKImageCropViewControllerDataSource {
    
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
        return indexPath.row >= imageNames.count
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

}
