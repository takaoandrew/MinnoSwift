//
//  SignUpViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 8/8/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit
import Firebase

class SignUpViewController: UIViewController {
    
    @IBOutlet weak var NameField: UITextField!
    @IBOutlet weak var PhoneField: UITextField!
    @IBOutlet weak var EmailField: UITextField!
    @IBOutlet weak var FacebookField: UITextField!
    @IBOutlet weak var InstagramField: UITextField!
    @IBOutlet weak var SnapchatField: UITextField!
    @IBOutlet weak var TwitterField: UITextField!
    @IBOutlet weak var LinkedinField: UITextField!
    @IBOutlet weak var SoundcloudField: UITextField!
    @IBOutlet weak var YoutubeField: UITextField!

    private var newUserRefHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        
        view.addGestureRecognizer(dismissKeyboardTap)
        
        // Do any additional setup after loading the view.
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let connect = Connect(name: NameField.text!, email: EmailField.text!, phone: PhoneField.text!, facebookName: FacebookField.text!, facebookId: FacebookField.text!, instagramName: InstagramField.text!, instagramId: InstagramField.text!, snapchatName: SnapchatField.text!, snapchatId: SnapchatField.text!, twitterName: TwitterField.text!, twitterId: TwitterField.text!, linkedinName: LinkedinField.text!, linkedinId: LinkedinField.text!, soundcloudName: SoundcloudField.text!, soundcloudId: SoundcloudField.text!, youtubeName: YoutubeField.text!, youtubeId: YoutubeField.text!)
        
        if let toViewController = segue.destination as? ProfileViewController {
            toViewController.profileInfo = connect
        }
        
        
        let userRef = Database.database().reference().child("users")
        
        
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            let tempRef = userRef.child(connect.name)
            tempRef.child("name").setValue(connect.name)
            tempRef.child("email").setValue(connect.email)
            tempRef.child("phone").setValue(connect.phone)
            tempRef.child("facebookName").setValue(connect.facebookName)
            tempRef.child("facebookId").setValue(connect.facebookId)
            tempRef.child("instagramName").setValue(connect.instagramName)
            tempRef.child("instagramId").setValue(connect.instagramName)
            tempRef.child("snapchatName").setValue(connect.snapchatName)
            tempRef.child("snapchatId").setValue(connect.snapchatId)
            tempRef.child("twitterName").setValue(connect.twitterName)
            tempRef.child("twitterId").setValue(connect.twitterId)
            tempRef.child("linkedinName").setValue(connect.linkedinName)
            tempRef.child("linkedinId").setValue(connect.linkedinId)
            tempRef.child("soundcloudName").setValue(connect.soundcloudName)
            tempRef.child("soundcloudId").setValue(connect.soundcloudId)
            tempRef.child("youtubeName").setValue(connect.youtubeName)
            tempRef.child("youtubeId").setValue(connect.youtubeId)
            
        })
        
    }


}
