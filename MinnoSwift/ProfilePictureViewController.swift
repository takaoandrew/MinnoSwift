//
//  ProfilePictureViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 7/1/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit

//class ProfilePictureViewController: UIViewController {
//    
//}
class ProfilePictureViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
//    @IBOutlet var imageView: UIImageView!
    @IBOutlet weak var chooseButton: UIButton!
    var imagePicker = UIImagePickerController()
    
    @IBAction func btnClicked(_ sender: Any) {
//        print("click")
//        chooseButton.setTitle("",for: .normal)
//        view.sendSubview(toBack: chooseButton)
        if UIImagePickerController.isSourceTypeAvailable(.savedPhotosAlbum){
//            print("Button capture")
            
            imagePicker.delegate = self
            imagePicker.sourceType = .savedPhotosAlbum;
            imagePicker.allowsEditing = false
            
            self.present(imagePicker, animated: true, completion: nil)
        }
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        
        /// chcek if you can return edited image that user choose it if user already edit it(crop it), return it as image
        if let editedImage = info[UIImagePickerControllerEditedImage] as? UIImage {
            
            /// if user update it and already got it , just return it to 'self.imgView.image'
            self.imageView.image = editedImage
            
            /// else if you could't find the edited image that means user select original image same is it without editing .
        } else if let orginalImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            
            /// if user update it and already got it , just return it to 'self.imgView.image'.
            self.imageView.image = orginalImage
        }
        else { print ("error") }
        
        /// if the request successfully done just dismiss
        picker.dismiss(animated: true, completion: nil)
        
    }
    
//    func imagePickerController(picker: UIImagePickerController!, didFinishPickingImage image: UIImage!, editingInfo: NSDictionary!){
//        self.dismiss(animated: true, completion: { () -> Void in
//            
//        })
//        
//        imageView.image = image
//    }
}


