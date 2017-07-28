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
            print("small picture")
            chatViewFrame = CGRect(x:0, y:270, width:self.view.bounds.size.width, height:self.view.bounds.size.height-270)
        }
        
        self.addViewControllerAsChildViewController(childViewController: viewController, cGRect: chatViewFrame)
        return viewController
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        
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
        
//        chatViewController.view.isHidden = false
//        profilePictureViewController.view.isHidden = false

        connectView.titleLabel?.textAlignment = NSTextAlignment.center
        friendView.titleLabel?.textAlignment = NSTextAlignment.center
        
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        
        view.bringSubview(toFront: facebookView)
        view.bringSubview(toFront: instagramView)
        view.bringSubview(toFront: snapchatView)
        view.bringSubview(toFront: twitterView)
        view.bringSubview(toFront: linkedinView)
        view.bringSubview(toFront: seemoreView)

    }
    
    func keyboardWillShow(notification: NSNotification) {
        print("showing")
        facebookView.isUserInteractionEnabled = false
        instagramView.isUserInteractionEnabled = false
        snapchatView.isUserInteractionEnabled = false
        twitterView.isUserInteractionEnabled = false
        linkedinView.isUserInteractionEnabled = false
        view.sendSubview(toBack: facebookView)
        view.sendSubview(toBack: instagramView)
        view.sendSubview(toBack: snapchatView)
        view.sendSubview(toBack: twitterView)
        view.sendSubview(toBack: linkedinView)
        view.sendSubview(toBack: seemoreView)
        
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
        view.bringSubview(toFront: facebookView)
        view.bringSubview(toFront: instagramView)
        view.bringSubview(toFront: snapchatView)
        view.bringSubview(toFront: twitterView)
        view.bringSubview(toFront: linkedinView)
        view.bringSubview(toFront: seemoreView)
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func facebookTapped(sender:UITapGestureRecognizer) {
//        let facebookHooks = "fb://profile/661299413"
//        let facebookUrl = NSURL(string: facebookHooks)
//        if UIApplication.shared.canOpenURL(facebookUrl! as URL)
//        {
//            UIApplication.shared.open(facebookUrl! as URL, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.open(NSURL(string: "http://facebook.com/trevor.massey.35")! as URL, options: [:], completionHandler: nil)
//        }
        apps.open(Applications.Facebook(), action: .open)
//        if let url = URL(string: "fb://profile/661299413") {
//            if #available(iOS 10, *) {
//                UIApplication.shared.open(url, options: [:],completionHandler: { (success) in
//                    print("Open fb://profile/661299413: \(success)")
//                })
//            } else {
//                let success = UIApplication.shared.openURL(url)
//                print("Open fb://profile/661299413: \(success)")
//            }
//        }

    }
    
    func instagramTapped(sender:UITapGestureRecognizer) {
//        let instagramHooks = "instagram://user?username=chocotako1"
//        let instagramUrl = NSURL(string: instagramHooks)
//        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
//        {
//            UIApplication.shared.open(instagramUrl! as URL, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.open(NSURL(string: "http://instagram.com/trev_mass")! as URL, options: [:], completionHandler: nil)
//        }
        apps.open(Applications.Instagram(), action: .open)
    }
    
    func snapchatTapped(sender:UITapGestureRecognizer) {
//        let snapchatHooks = "snapchat://add/chocotako"
//        let snapchatUrl = NSURL(string: snapchatHooks)
//        if UIApplication.shared.canOpenURL(snapchatUrl! as URL)
//        {
//            UIApplication.shared.open(snapchatUrl! as URL, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.open(NSURL(string: "http://snapchat.com/tmass9")! as URL, options: [:], completionHandler: nil)
//        }
        apps.open(Applications.Snapchat(), action: .open)
    }
    
    func twitterTapped(sender:UITapGestureRecognizer) {
//        let twitterHooks = "twitter://twitterusrnamehere"
//        let twitterUrl = NSURL(string: twitterHooks)
//        if UIApplication.shared.canOpenURL(twitterUrl! as URL)
//        {
//            UIApplication.shared.open(twitterUrl! as URL, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.open(NSURL(string: "http://twitter.com/Trev_mass")! as URL, options: [:], completionHandler: nil)
//        }
        apps.open(Applications.Photos(), action: .open)
    }
    
    func linkedinTapped(sender:UITapGestureRecognizer) {
//        let linkedinHooks = "linkedin://add/andrew-takao"
//        let linkedinUrl = NSURL(string: linkedinHooks)
//        if UIApplication.shared.canOpenURL(linkedinUrl! as URL)
//        {
//            UIApplication.shared.open(linkedinUrl! as URL, options: [:], completionHandler: nil)
//        } else {
//            UIApplication.shared.open(NSURL(string: "http://linkedin.com/")! as URL, options: [:], completionHandler: nil)
//        }
        apps.open(Applications.Linkedin(), action: .open)
    }
    
    
    @IBAction func contactClicked(_ sender: Any) {
        contactInformation.isHidden = false
        contactView.isHidden = true
    }

    @IBAction func seemoreClicked(_ sender: Any) {
        snapchatView.isHidden = false
        twitterView.isHidden = false
        linkedinView.isHidden = false
        seelessView.isHidden = false
        seemoreView.isHidden = true
        chatViewController.view.frame = CGRect(x:0, y:550, width:view.bounds.size.width, height:view.bounds.size.height-550)

    }

    @IBAction func seelessClicked(_ sender: Any) {
        snapchatView.isHidden = true
        twitterView.isHidden = true
        linkedinView.isHidden = true
        seelessView.isHidden = true
        seemoreView.isHidden = false
        var chatViewFrame: CGRect
        
        if self.view.bounds.size.height >= 580 {
            chatViewFrame = CGRect(x:0, y:400, width:self.view.bounds.size.width, height:self.view.bounds.size.height-400)
        }
        else {
            print("small picture")
            chatViewFrame = CGRect(x:0, y:360, width:self.view.bounds.size.width, height:self.view.bounds.size.height-360)
        }
        chatViewController.view.frame = chatViewFrame
    }
}
