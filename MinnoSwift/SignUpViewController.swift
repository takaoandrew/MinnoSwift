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
    
//    @IBOutlet weak var ScrollView: UIScrollView!
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
    
    @IBOutlet weak var FacebookCheck: UIImageView!
    @IBOutlet weak var InstagramCheck: UIImageView!
    @IBOutlet weak var SnapchatCheck: UIImageView!
    @IBOutlet weak var TwitterCheck: UIImageView!
    @IBOutlet weak var LinkedinCheck: UIImageView!
    @IBOutlet weak var SoundcloudCheck: UIImageView!
    @IBOutlet weak var YoutubeCheck: UIImageView!
    
    @IBOutlet weak var FacebookX: UIImageView!
    @IBOutlet weak var InstagramX: UIImageView!
    @IBOutlet weak var SnapchatX: UIImageView!
    @IBOutlet weak var TwitterX: UIImageView!
    @IBOutlet weak var LinkedinX: UIImageView!
    @IBOutlet weak var SoundcloudX: UIImageView!
    @IBOutlet weak var YoutubeX: UIImageView!
    
//    @IBOutlet var keyboardHeightLayoutConstraint: NSLayoutConstraint?
//
//    private var oldScrollFrame: CGRect!
//    private var newScrollFrame: CGRect!
//    private var oldContentSize: CGSize!
//    private var newUserRefHandle: DatabaseHandle?
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
//        oldScrollFrame = ScrollView.frame
//        oldContentSize = ScrollView.contentSize
//        ScrollView.contentSize = CGSize(width: 20, height: 20)
        
        NotificationCenter.default.addObserver(self, selector: #selector(SignUpViewController.keyboardWillShow(_:)), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SignUpViewController.dismissKeyboard))
        
        FacebookField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        InstagramField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        SnapchatField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        TwitterField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        LinkedinField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        SoundcloudField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
        YoutubeField.addTarget(self, action: #selector(textFieldDidChange(sender:)), for: .editingChanged)
//        
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    func textFieldDidChange(sender: UITextField){
        var checkImageView: UIImageView
        var xImageView: UIImageView
        var hookString: String
        let idString = sender.text ?? ""
        switch sender {
        case FacebookField:
            checkImageView = FacebookCheck
            xImageView = FacebookX
            hookString = "fb://profile/"
        case InstagramField:
            checkImageView = InstagramCheck
            xImageView = InstagramX
            hookString = "instagram://"
        case SnapchatField:
            checkImageView = SnapchatCheck
            xImageView = SnapchatX
            hookString = "snapchat://"
        case TwitterField:
            checkImageView = TwitterCheck
            xImageView = TwitterX
            hookString = "twitter://"
        case LinkedinField:
            checkImageView = LinkedinCheck
            xImageView = LinkedinX
            hookString = "linkedin://"
        case SoundcloudField:
            checkImageView = SoundcloudCheck
            xImageView = SoundcloudX
            hookString = "soundcloud://"
        case YoutubeField:
            checkImageView = YoutubeCheck
            xImageView = YoutubeX
            hookString = "youtube://"
        default:
            checkImageView = FacebookCheck
            xImageView = FacebookX
            hookString = "fb://profile/"
        }
        checkImageView.isHidden = true
        xImageView.isHidden = true
        if sender.text! != "" {
            let handleHooks = hookString + idString
            let handleURL = NSURL(string: handleHooks)
            if UIApplication.shared.canOpenURL(handleURL! as URL)
            {
                checkImageView.isHidden = false
            }
            else {
                xImageView.isHidden = false
            }
        }
    }
//
//    func textFieldDidBeginEditing(textField: UITextField){
//        print("began editing")
//    }
    
    func checkFacebookHandle() {
        if FacebookField.text! != "" {
            let facebookId = FacebookField.text!
            let facebookHooks = "fb://profile/" + facebookId
            let facebookUrl = NSURL(string: facebookHooks)
            if UIApplication.shared.canOpenURL(facebookUrl! as URL)
            {
                FacebookX.isHidden = true
                FacebookCheck.isHidden = false
            }
            else {
                FacebookX.isHidden = false
                FacebookCheck.isHidden = true
            }
        }
    }
    
    func keyboardWillShow(_ notification: Notification) {
        print("yup")
        if let keyboardFrame: NSValue = notification.userInfo?[UIKeyboardFrameEndUserInfoKey] as? NSValue {
            
            let keyboardHeight = keyboardFrame.cgRectValue.height
            print("uhuh")
            print(keyboardHeight)
//            ScrollView.contentSize = CGSize(width: 20, height: 20)
//            ScrollView.frame = CGRect(x: oldScrollFrame.origin.x, y: oldScrollFrame.origin.y, width: 20, height: 20)
        }
        
    }
    
    func dismissKeyboard() {
        
//        ScrollView.frame = CGRect(x: 0, y: 0, width:self.screenSize.width, height:self.screenSize.height)
//        ScrollView.contentSize = CGSize(width:self.screenSize.width, height: self.screenSize.height)
        view.endEditing(true)
//        checkHandle()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let connect = Connect(name: NameField.text!, email: EmailField.text!, phone: PhoneField.text!, facebookName: FacebookField.text!, facebookId: FacebookField.text!, instagramName: InstagramField.text!, instagramId: InstagramField.text!, snapchatName: SnapchatField.text!, snapchatId: SnapchatField.text!, twitterName: TwitterField.text!, twitterId: TwitterField.text!, linkedinName: LinkedinField.text!, linkedinId: LinkedinField.text!, soundcloudName: SoundcloudField.text!, soundcloudId: SoundcloudField.text!, youtubeName: YoutubeField.text!, youtubeId: YoutubeField.text!, profileImage: NameField.text!+".png")
        
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
            tempRef.child("profileImage").setValue(connect.profileImage)
            
        })
        
    }


}
