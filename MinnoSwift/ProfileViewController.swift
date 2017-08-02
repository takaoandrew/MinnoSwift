//
//  ProfileViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 6/25/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit
import Firebase
import JSQMessagesViewController
import Appz


class ProfileViewController: UIViewController {
    
    let apps = UIApplication.shared
    
    var programVar : String?
    var profileInfo : Connect?
    
    //    var addRemoveTableViewController: AddRemoveTableViewController = AddRemoveTableViewController
    
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var facebookNameView: UILabel!
    @IBOutlet weak var instagramNameView: UILabel!
    @IBOutlet weak var snapchatNameView: UILabel!
    @IBOutlet weak var twitterNameView: UILabel!
    @IBOutlet weak var linkedinNameView: UILabel!
    @IBOutlet weak var contactView: UIButton!
    @IBOutlet weak var echoView: UIButton!
    @IBOutlet weak var contactInformation: UILabel!
    @IBOutlet weak var connectView: UIButton!
    @IBOutlet weak var friendView: UIButton!
    @IBOutlet weak var seemoreView: UIButton!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var instagramView: UIView!
    @IBOutlet weak var snapchatView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var linkedinView: UIView!
    @IBOutlet weak var seelessView: UIButton!
    @IBOutlet weak var chatContainerView: UIView!
    @IBOutlet weak var profilePictureContainerView: UIView!
    @IBOutlet weak var facebookYConstraint: NSLayoutConstraint!
    @IBOutlet weak var instagramYConstraint: NSLayoutConstraint!
    @IBOutlet weak var snapchatYConstraint: NSLayoutConstraint!
    @IBOutlet weak var twitterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var linkedinYConstraint: NSLayoutConstraint!
    
    lazy var profilePictureViewController: ProfilePictureViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var profilePictureController = storyboard.instantiateViewController(withIdentifier: "ProfilePictureViewController") as! ProfilePictureViewController
        var profilePictureViewFrame: CGRect
        if self.view.bounds.size.height >= 580 {
            profilePictureViewFrame = CGRect(x:16, y:105, width:109, height:118)
        }
        else {
            print("small picture")
            profilePictureViewFrame = CGRect(x:35, y:105, width:90, height:57)
        }
        self.addViewControllerAsChildViewController(childViewController: profilePictureController, cGRect: profilePictureViewFrame)
        return profilePictureController
        
    }()
    
    lazy var chatViewController: ChatViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        var chatViewFrame: CGRect
        
        if self.view.bounds.size.height >= 580 {
            chatViewFrame = CGRect(x:0, y:400, width:self.view.bounds.size.width, height:self.view.bounds.size.height-400)
        }
        else {
            //            print("small picture")
            chatViewFrame = CGRect(x:0, y:270, width:self.view.bounds.size.width, height:self.view.bounds.size.height-270)
        }
        
        self.addViewControllerAsChildViewController(childViewController: viewController, cGRect: chatViewFrame)
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameView.text = profileInfo?.name ?? "Andrew Takao"
        facebookNameView.text = profileInfo?.facebookName ?? "takaoandrew"
        instagramNameView.text = profileInfo?.instagramName ?? "andrewtakao"
        snapchatNameView.text = profileInfo?.snapchatName ?? "chocotako"
        twitterNameView.text = profileInfo?.twitterName ?? "tweetakao"
        linkedinNameView.text = profileInfo?.linkedinName ?? "Andrew Takao"
        
        
        let facebookTap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.facebookTapped(sender:)))
        facebookView.addGestureRecognizer(facebookTap)
        
        let instagramTap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.instagramTapped(sender:)))
        instagramView.addGestureRecognizer(instagramTap)
        
        let snapchatTap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.snapchatTapped(sender:)))
        snapchatView.addGestureRecognizer(snapchatTap)
        
        let twitterTap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.twitterTapped(sender:)))
        twitterView.addGestureRecognizer(twitterTap)
        
        let linkedinTap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.linkedinTapped(sender:)))
        linkedinView.addGestureRecognizer(linkedinTap)
        
        chatViewController.view.isHidden = false
        profilePictureViewController.view.isHidden = false
        
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboard))
        
        view.addGestureRecognizer(dismissKeyboardTap)
        
        connectView.titleLabel?.textAlignment = NSTextAlignment.center
        friendView.titleLabel?.textAlignment = NSTextAlignment.center
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
    }
    
    func keyboardWillShow(notification: NSNotification) {
        print("showing")
        facebookView.isUserInteractionEnabled = false
        instagramView.isUserInteractionEnabled = false
        snapchatView.isUserInteractionEnabled = false
        twitterView.isUserInteractionEnabled = false
        linkedinView.isUserInteractionEnabled = false
        view.bringSubview(toFront: chatViewController.view)
    }
    
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController, cGRect: CGRect) {
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = cGRect
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
        facebookView.isUserInteractionEnabled = true
        instagramView.isUserInteractionEnabled = true
        snapchatView.isUserInteractionEnabled = true
        twitterView.isUserInteractionEnabled = true
        linkedinView.isUserInteractionEnabled = true
        view.sendSubview(toBack: chatViewController.view)
        seelessClicked((Any).self)
    }
    
    func bumpUp(view: UIView)  {
        view.frame.origin.y -= 50
    }
    
    func bumpDown(view: UIView)  {
        view.frame.origin.y += 50
    }
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        let ref = Database.database().reference()
        ref.child("add_remove_settings").observeSingleEvent(of: .value, with: { snapshot in
            let settingsData = snapshot.value as! Dictionary<String, Dictionary<String, String>>
            for (key, element) in settingsData {
                if key == "facebook" {
                    if  element["show"] == "hide" {
                        self.facebookView.isHidden = true
                        self.bumpUp(view: self.instagramView)
                        self.bumpUp(view: self.seemoreView)
                        self.bumpUp(view: self.snapchatView)
                        self.bumpUp(view: self.twitterView)
                        self.bumpUp(view: self.linkedinView)
                        self.bumpUp(view: self.seelessView)
                    }
                    else {
                        self.facebookView.isHidden = false
                    }
                }
                else if key == "instagram" {
                    if  element["show"] == "hide" {
                        self.instagramView.isHidden = true
                        self.bumpUp(view: self.seemoreView)
                        self.bumpUp(view: self.snapchatView)
                        self.bumpUp(view: self.twitterView)
                        self.bumpUp(view: self.linkedinView)
                        self.bumpUp(view: self.seelessView)
                    }
                    else {
                        self.instagramView.isHidden = false
                    }
                }
                else if key == "snapchat" {
                    if  element["show"] == "hide" {
                        self.snapchatView.isHidden = true
                        self.bumpUp(view: self.twitterView)
                        self.bumpUp(view: self.linkedinView)
                        self.bumpUp(view: self.seelessView)
                    }
                    else {
                        self.snapchatView.isHidden = false
                    }
                }
                else if key == "twitter" {
                    if  element["show"] == "hide" {
                        self.twitterView.isHidden = true
                        self.bumpUp(view: self.linkedinView)
                        self.bumpUp(view: self.seelessView)
                    }
                    else {
                        self.twitterView.isHidden = false
                    }
                }
                else if key == "linkedin" {
                    if  element["show"] == "hide" {
                        self.linkedinView.isHidden = true
                        self.bumpUp(view: self.seelessView)
                    }
                    else {
                        self.linkedinView.isHidden = false
                    }
                }
            }
        })
        view.bringSubview(toFront: facebookView)
        view.bringSubview(toFront: instagramView)
        view.bringSubview(toFront: snapchatView)
        view.bringSubview(toFront: twitterView)
        view.bringSubview(toFront: linkedinView)
        view.bringSubview(toFront: seemoreView)
        
        seelessClicked((Any).self)
        
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        let ref = Database.database().reference()
        ref.child("add_remove_settings").observeSingleEvent(of: .value, with: { snapshot in
            let settingsData = snapshot.value as! Dictionary<String, Dictionary<String, String>>
            for (key, element) in settingsData {
                if key == "facebook" {
                    if  element["show"] == "hide" {
                        self.bumpDown(view: self.instagramView)
                        self.bumpDown(view: self.seemoreView)
                        self.bumpDown(view: self.snapchatView)
                        self.bumpDown(view: self.twitterView)
                        self.bumpDown(view: self.linkedinView)
                        self.bumpDown(view: self.seelessView)
                    }
                }
                else if key == "instagram" {
                    if  element["show"] == "hide" {
                        self.bumpDown(view: self.seemoreView)
                        self.bumpDown(view: self.snapchatView)
                        self.bumpDown(view: self.twitterView)
                        self.bumpDown(view: self.linkedinView)
                        self.bumpDown(view: self.seelessView)
                    }
                }
                else if key == "snapchat" {
                    if  element["show"] == "hide" {
                        self.bumpDown(view: self.twitterView)
                        self.bumpDown(view: self.linkedinView)
                        self.bumpDown(view: self.seelessView)
                    }
                }
                else if key == "twitter" {
                    if  element["show"] == "hide" {
                        self.bumpDown(view: self.linkedinView)
                        self.bumpDown(view: self.seelessView)
                    }
                }
                else if key == "linkedin" {
                    if  element["show"] == "hide" {
                        self.bumpDown(view: self.seelessView)
                    }
                }
            }
        })
        
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func facebookTapped(sender:UITapGestureRecognizer) {
        //        let facebookHooks = "fb://profile/661299413"
        //        apps.open(Applications.Facebook(), action: .profile)
        let facebookId = profileInfo?.facebookId ?? "661299413"
        let facebookHooks = "fb://profile/" + facebookId
        let facebookUrl = NSURL(string: facebookHooks)
        if UIApplication.shared.canOpenURL(facebookUrl! as URL)
        {
            UIApplication.shared.open(facebookUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://facebook.com/")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    func instagramTapped(sender:UITapGestureRecognizer) {
        //        let instagramHooks = "instagram://user?username=chocotako1"
        let instagramId = profileInfo?.instagramId ?? "chocotako1"
        apps.open(Applications.Instagram(), action: .username(username: instagramId))
    }
    
    func snapchatTapped(sender:UITapGestureRecognizer) {
        //        apps.open(Applications.Snapchat(), action: .add(username: "chocotako"))
        //        snapchat://add/snapchatUsername
        let snapchatId = profileInfo?.snapchatId ?? "chocotako"
        let snapchatHooks = "snapchat://add/" + snapchatId
        let snapchatUrl = NSURL(string: snapchatHooks)
        if UIApplication.shared.canOpenURL(snapchatUrl! as URL)
        {
            UIApplication.shared.open(snapchatUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://snapchat.com/")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    func twitterTapped(sender:UITapGestureRecognizer) {
        let twitterId = profileInfo?.twitterId ?? "Trev_mass"
        apps.open(Applications.Twitter(), action: .userHandle(twitterId))
        //        let twitterHooks = "twitter://user?screen_name=Trev_mass"
        //                let twitterUrl = NSURL(string: twitterHooks)
        //                if UIApplication.shared.canOpenURL(twitterUrl! as URL)
        //                    {
        //                            UIApplication.shared.open(twitterUrl! as URL, options: [:], completionHandler: nil)
        //                        } else {
        //                        UIApplication.shared.open(NSURL(string: "http://twitter.com/")! as URL, options: [:], completionHandler: nil)
        //                }
        
    }
    
    func linkedinTapped(sender:UITapGestureRecognizer) {
        let linkedinId = profileInfo?.linkedinId ?? "andrew-takao"
        let linkedinHooks = "linkedin://add/" + linkedinId
        let linkedinUrl = NSURL(string: linkedinHooks)
        if UIApplication.shared.canOpenURL(linkedinUrl! as URL)
        {
            UIApplication.shared.open(linkedinUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://linkedin.com/")! as URL, options: [:], completionHandler: nil)
        }
        //        apps.open(Applications.Linkedin(), action: .open)
    }
    
    
    @IBAction func contactClicked(_ sender: Any) {
        contactInformation.isHidden = false
        contactView.isHidden = true
    }
    
    @IBAction func seemoreClicked(_ sender: Any) {
        view.bringSubview(toFront: snapchatView)
        view.bringSubview(toFront: twitterView)
        view.bringSubview(toFront: linkedinView)
        view.sendSubview(toBack: seemoreView)
        view.bringSubview(toFront: seelessView)
    }
    
    @IBAction func seelessClicked(_ sender: Any) {
        view.sendSubview(toBack: snapchatView)
        view.sendSubview(toBack: twitterView)
        view.sendSubview(toBack: linkedinView)
        view.sendSubview(toBack: seelessView)
        view.bringSubview(toFront: seemoreView)
    }
}
