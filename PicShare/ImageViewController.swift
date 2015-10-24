//
//  ImageViewController.swift
//  PicShare
//
//  Created by Pablo Arango on 10/23/15.
//  Copyright © 2015 Pablo Arango. All rights reserved.
//

import UIKit
import Parse
import ParseUI

class ImageViewController: UIViewController,
    UIImagePickerControllerDelegate,
UINavigationControllerDelegate {
    
    @IBOutlet weak var myImageView: UIImageView!
    let picker = UIImagePickerController()
    
    
    @IBOutlet weak var uploadButton: UIButton!
    
    func noCamera(){
        let alertVC = UIAlertController(
            title: "No Camera",
            message: "Sorry, this device has no camera",
            preferredStyle: .Alert)
        let okAction = UIAlertAction(
            title: "OK",
            style:.Default,
            handler: nil)
        alertVC.addAction(okAction)
        presentViewController(
            alertVC,
            animated: true,
            completion: nil)
    }
    
    
    @IBAction func photoFromLibrary(sender: UIBarButtonItem) {
        picker.allowsEditing = false //2
        picker.sourceType = .PhotoLibrary //3
        picker.modalPresentationStyle = .Popover
        presentViewController(picker,
            animated: true,
            completion: nil)//4
        picker.popoverPresentationController?.barButtonItem = sender
    }
    
    
    
    @IBAction func shootPhoto(sender: UIBarButtonItem) {
        if UIImagePickerController.availableCaptureModesForCameraDevice(.Rear) != nil {
            picker.allowsEditing = false
            picker.sourceType = UIImagePickerControllerSourceType.Camera
            picker.cameraCaptureMode = .Photo
            picker.modalPresentationStyle = .FullScreen
            presentViewController(picker,
                animated: true,
                completion: nil)
        } else {
            noCamera()
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        
        picker.delegate = self
    }
    func imagePickerController(
        picker: UIImagePickerController,
        didFinishPickingMediaWithInfo info: [String : AnyObject])
    {
        let chosenImage = info[UIImagePickerControllerOriginalImage] as! UIImage
        myImageView.contentMode = .ScaleAspectFit
        myImageView.image = chosenImage
        dismissViewControllerAnimated(true, completion: nil)
        uploadButton.hidden = false;
        
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true,
            completion: nil)
    }
    
    
    @IBAction func uploadImage(sender: AnyObject) {
        
        let anImage = myImageView.image!
        
        let resizedImage: UIImage = resizeImage(anImage, targetSize: CGSizeMake(560.0, 560.0))
        
        // JPEG to decrease file size and enable faster uploads & downloads
        guard let imageData: NSData = UIImageJPEGRepresentation(resizedImage, 0.8) else { return }
        
        let photoFile = PFFile(data: imageData)
        
        photoFile!.saveInBackgroundWithBlock { (succeeded, error) in
            if (succeeded) {
                print("Photo uploaded successfully")
            }
        }
        
        let photo = PFObject(className: "Photo")
        photo.setObject(PFUser.currentUser()!.username!, forKey: "user")
        photo.setObject(photoFile!, forKey: "photo")
        
        photo.saveInBackgroundWithBlock { (succeeded, error ) -> Void in
            if succeeded {
                print("Photo uploaded")
                }
        }
        self.reloadInputViews()
        
        self.tabBarController?.selectedIndex = 0
        
        
        
    }
    
    
    
    
    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }
    
    func resizeImage(image: UIImage, targetSize: CGSize) -> UIImage {
        let size = image.size
        
        let widthRatio  = targetSize.width  / image.size.width
        let heightRatio = targetSize.height / image.size.height
        
        // Figure out what our orientation is, and use that to form the rectangle
        var newSize: CGSize
        if(widthRatio > heightRatio) {
            newSize = CGSizeMake(size.width * heightRatio, size.height * heightRatio)
        } else {
            newSize = CGSizeMake(size.width * widthRatio,  size.height * widthRatio)
        }
        
        // This is the rect that we've calculated out and this is what is actually used below
        let rect = CGRectMake(0, 0, newSize.width, newSize.height)
        
        // Actually do the resizing to the rect using the ImageContext stuff
        UIGraphicsBeginImageContextWithOptions(newSize, false, 1.0)
        image.drawInRect(rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    
    
}


