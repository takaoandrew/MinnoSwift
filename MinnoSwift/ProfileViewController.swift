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

class ProfileViewController: UIViewController {

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
    
    lazy var chatViewController: ChatViewController = {
        let storyboard = UIStoryboard(name: "Main", bundle: Bundle.main)
        
        var viewController = storyboard.instantiateViewController(withIdentifier: "ChatViewController") as! ChatViewController
        
        self.addViewControllerAsChildViewController(childViewController: viewController)
        return viewController
    }()
    
    override func viewDidLoad() {
        chatViewController.view.isHidden = false
        super.viewDidLoad()
        
//        chatContainerView.classForCoder(JSQMessagesViewController)
//        addChildViewController(JSQMessagesViewController)
//        view.addSubview(JSQMessagesViewController.view)
//        JSQMessagesViewController.didMove(toParentViewController: self)
        
        
        
        connectView.titleLabel?.textAlignment = NSTextAlignment.center
        friendView.titleLabel?.textAlignment = NSTextAlignment.center
        
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
        
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboard))
        
        //Uncomment the line below if you want the tap not not interfere and cancel other interactions.
        //tap.cancelsTouchesInView = false
        
        view.addGestureRecognizer(dismissKeyboardTap)
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController) {
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = CGRect(x:0, y:400, width:view.bounds.size.width, height:view.bounds.size.height-400)
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
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
        let facebookHooks = "fb://profile/661299413"
        let facebookUrl = NSURL(string: facebookHooks)
        if UIApplication.shared.canOpenURL(facebookUrl! as URL)
        {
            UIApplication.shared.open(facebookUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://facebook.com/")! as URL, options: [:], completionHandler: nil)
        }

    }
    
    func instagramTapped(sender:UITapGestureRecognizer) {
        let instagramHooks = "instagram://user?username=chocotako1"
        let instagramUrl = NSURL(string: instagramHooks)
        if UIApplication.shared.canOpenURL(instagramUrl! as URL)
        {
            UIApplication.shared.open(instagramUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://instagram.com/")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    func snapchatTapped(sender:UITapGestureRecognizer) {
        let snapchatHooks = "snapchat://add/chocotako"
        let snapchatUrl = NSURL(string: snapchatHooks)
        if UIApplication.shared.canOpenURL(snapchatUrl! as URL)
        {
            UIApplication.shared.open(snapchatUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://snapchat.com/")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    func twitterTapped(sender:UITapGestureRecognizer) {
        let twitterHooks = "twitter://twitterusrnamehere"
        let twitterUrl = NSURL(string: twitterHooks)
        if UIApplication.shared.canOpenURL(twitterUrl! as URL)
        {
            UIApplication.shared.open(twitterUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://twitter.com/")! as URL, options: [:], completionHandler: nil)
        }
    }
    
    func linkedinTapped(sender:UITapGestureRecognizer) {
        let linkedinHooks = "linkedin://add/andrew-takao"
        let linkedinUrl = NSURL(string: linkedinHooks)
        if UIApplication.shared.canOpenURL(linkedinUrl! as URL)
        {
            UIApplication.shared.open(linkedinUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://linkedin.com/")! as URL, options: [:], completionHandler: nil)
        }
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
    }

    @IBAction func seelessClicked(_ sender: Any) {
        snapchatView.isHidden = true
        twitterView.isHidden = true
        linkedinView.isHidden = true
        seelessView.isHidden = true
        seemoreView.isHidden = false
    }
}
