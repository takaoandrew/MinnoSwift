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

extension ProfileViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
}

extension ProfileViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

class ProfileViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
    
    lazy var profilePictureViewController: ProfilePictureViewController = {
        let storyboard = UIStoryboard(name: "5s", bundle: Bundle.main)
        
        var profilePictureController = storyboard.instantiateViewController(withIdentifier: "ProfilePictureViewController") as! ProfilePictureViewController
        var profilePictureViewFrame: CGRect
        if self.view.bounds.size.height >= 580 {
            profilePictureViewFrame = CGRect(x:16, y:105, width:109, height:118)
        }
        else {
            //            print("small picture")
            profilePictureViewFrame = CGRect(x:35, y:105, width:90, height:57)
        }
        self.addViewControllerAsChildViewController(childViewController: profilePictureController, cGRect: profilePictureViewFrame)
        return profilePictureController
    }()
    
    let apps = UIApplication.shared
    
    var defaultProfileInfo = Connect(name: "Test Name", email: "TestEmail", phone: "Test Phone", facebookName: "", facebookId: "", instagramName: "", instagramId: "", snapchatName: "", snapchatId: "", twitterName: "", twitterId: "", linkedinName: "", linkedinId: "", soundcloudName: "", soundcloudId: "", youtubeName: "", youtubeId: "")
    
    var profileInfo : Connect?
    var privacyInfo : Connect?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var connects = [Connect]()
    var filteredConnects = [Connect]()
    
    @IBOutlet weak var connectTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var facebookNameView: UILabel!
    @IBOutlet weak var instagramNameView: UILabel!
    @IBOutlet weak var snapchatNameView: UILabel!
    @IBOutlet weak var twitterNameView: UILabel!
    @IBOutlet weak var linkedinNameView: UILabel!
    @IBOutlet weak var soundcloudNameView: UILabel!
    @IBOutlet weak var youtubeNameView: UILabel!
    
    @IBOutlet weak var contactView: UIButton!
    @IBOutlet weak var echoView: UIButton!
    @IBOutlet weak var contactInformation: UILabel!
    @IBOutlet weak var connectView: UIButton!
    @IBOutlet weak var friendView: UIButton!
    
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var instagramView: UIView!
    @IBOutlet weak var snapchatView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var linkedinView: UIView!
    @IBOutlet weak var soundcloudView: UIView!
    @IBOutlet weak var youtubeView: UIView!
    
    @IBOutlet weak var chatContainerView: UIView!
    @IBOutlet weak var profilePictureContainerView: UIView!
    @IBOutlet weak var facebookYConstraint: NSLayoutConstraint!
    @IBOutlet weak var instagramYConstraint: NSLayoutConstraint!
    @IBOutlet weak var snapchatYConstraint: NSLayoutConstraint!
    @IBOutlet weak var twitterYConstraint: NSLayoutConstraint!
    @IBOutlet weak var linkedinYConstraint: NSLayoutConstraint!
    @IBOutlet weak var ConnectButton: UIButton!
    
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredConnects = connects.filter { connect in
            return  connect.name.lowercased().contains(searchText.lowercased())
        }
        
        connectTableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if !searchController.isActive {
            return 0
        }
        else if searchController.searchBar.text != "" {
            return filteredConnects.count
        }
        else {
            return connects.count
        }
    }
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        print("should hide")
        profilePictureContainerView.isHidden = true
    }
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        profilePictureContainerView.isHidden = false
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectCell", for: indexPath)
        let connect: Connect
        if searchController.isActive && searchController.searchBar.text != "" {
            connect = filteredConnects[indexPath.row]
        }
        else {
            connect = connects[indexPath.row]
        }
        cell.textLabel!.text = connect.name
        cell.imageView?.image = #imageLiteral(resourceName: "avatar")
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        return
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("ViewDidLoad")
        
//        let userRef = Database.database().reference().child("users")
//        userRef.observeSingleEvent(of: .value, with: { snapshot in
//            let allUsers = snapshot.value as! Dictionary<String, Dictionary<String, String>>
//            for name in allUsers {
//                print(name.key)
//            }
//            
//            
//        })

        var names = [String]()
        let userRef = Database.database().reference().child("users")
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            let allUsers = snapshot.value as! Dictionary<String, Dictionary<String, String>>
            for name in allUsers {
                names.append(name.key)
            }
            
            for child in snapshot.children {
                let tempRef = userRef.child(names.popLast()!)
                tempRef.observeSingleEvent(of: .value, with: { snapshot in
                    let currentUser = snapshot.value as! Dictionary<String, String>
                    print("currentUserName")
                    print(currentUser["name"]!)
                    self.connects.append(Connect(
                        name: currentUser["name"]!,
                        email: currentUser["email"]!,
                        phone: currentUser["phone"]!,
                        facebookName: currentUser["facebookName"]!,
                        facebookId: currentUser["facebookId"]!,
                        instagramName: currentUser["instagramName"]!,
                        instagramId: currentUser["instagramId"]!,
                        snapchatName: currentUser["snapchatName"]!,
                        snapchatId: currentUser["snapchatId"]!,
                        twitterName: currentUser["twitterName"]!,
                        twitterId: currentUser["twitterId"]!,
                        linkedinName: currentUser["linkedinName"]!,
                        linkedinId: currentUser["linkedinId"]!,
                        soundcloudName: currentUser["soundcloudName"]!,
                        soundcloudId: currentUser["soundcloudId"]!,
                        youtubeName: currentUser["youtubeName"]!,
                        youtubeId: currentUser["youtubeId"]!))
                })
            }

        })

        
        
        
        connectTableView.backgroundColor = UIColor.clear
        
//        connects = [
//            Connect(name:"Trevor Massey", email: "trevmass@gmail.com", phone: "123-456-7890",
//                    facebookName: "trevor massey", facebookId: "1565426905",
//                    instagramName: "trev_mass", instagramId: "trev_mass", snapchatName: "tmass9", snapchatId: "tmass9",
//                    twitterName: "trev_mass", twitterId: "trev_mass", linkedinName: "trev_mass", linkedinId: "trev_mass",
//                    soundcloudName: "trev_mass", soundcloudId: "trev_mass", youtubeName: "trev_mass", youtubeId: "trev_mass"),
//            Connect(name:"Andrew Takao", email: "takaoandrew@gmail.com", phone: "631-398-9782",
//                    facebookName: "Andrew Takao", facebookId: "661299413",
//                    instagramName: "chocotako1", instagramId: "chocotako1", snapchatName: "chocotako", snapchatId: "chocotako",
//                    twitterName: "trev_mass", twitterId: "trev_mass", linkedinName: "andrew-takao", linkedinId: "andrew-takao",
//                    soundcloudName: "trev_mass", soundcloudId: "trev_mass", youtubeName: "Takao productions", youtubeId: "trev_mass")
//        ]
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        connectTableView.tableHeaderView = searchController.searchBar
        
        nameView.text = profileInfo?.name ?? "Andrew Takao"
        contactInformation.text = ((profileInfo?.email) ?? "takaoandrew@gmail.com") + "\r" + (profileInfo?.phone ?? "631-398-9782")
        facebookNameView.text = profileInfo?.facebookName ?? "takaoandrew"
        instagramNameView.text = profileInfo?.instagramName ?? "andrewtakao"
        snapchatNameView.text = profileInfo?.snapchatName ?? "chocotako"
        twitterNameView.text = profileInfo?.twitterName ?? "tweetakao"
        linkedinNameView.text = profileInfo?.linkedinName ?? "Andrew Takao"
        soundcloudNameView.text = profileInfo?.soundcloudName ?? "Andrew Takao"
        youtubeNameView.text = profileInfo?.youtubeName ?? "Takao Productions"
        
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
        let soundcloudTap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.soundcloudTapped(sender:)))
        soundcloudView.addGestureRecognizer(soundcloudTap)
        let youtubeTap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.youtubeTapped(sender:)))
        youtubeView.addGestureRecognizer(youtubeTap)
        profilePictureViewController.view.isHidden = false
        
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboard))
        view.addGestureRecognizer(dismissKeyboardTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        searchBar.delegate = self
        connectTableView.delegate = self
        connectTableView.dataSource = self
        view.bringSubview(toFront: connectTableView)
//        view.sendSubview(toBack: profilePictureContainerView)
        
        connectView.titleLabel?.textAlignment = NSTextAlignment.center
        friendView.titleLabel?.textAlignment = NSTextAlignment.center
    }
    
    func keyboardWillShow(notification: NSNotification) {
//        profilePictureViewController.view.isHidden = true
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
//        profilePictureViewController.view.isHidden = false
    }
    
    private func addViewControllerAsChildViewController(childViewController: UIViewController, cGRect: CGRect) {
        addChildViewController(childViewController)
        view.addSubview(childViewController.view)
        childViewController.view.frame = cGRect
        childViewController.view.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        childViewController.didMove(toParentViewController: self)
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
                        self.bumpUp(view: self.snapchatView)
                        self.bumpUp(view: self.twitterView)
                        self.bumpUp(view: self.linkedinView)
                        self.bumpUp(view: self.soundcloudView)
                        self.bumpUp(view: self.youtubeView)
                    }
                    else {
                        self.facebookView.isHidden = false
                    }
                }
                else if key == "instagram" {
                    if  element["show"] == "hide" {
                        self.instagramView.isHidden = true
                        self.bumpUp(view: self.snapchatView)
                        self.bumpUp(view: self.twitterView)
                        self.bumpUp(view: self.linkedinView)
                        self.bumpUp(view: self.soundcloudView)
                        self.bumpUp(view: self.youtubeView)
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
                        self.bumpUp(view: self.soundcloudView)
                        self.bumpUp(view: self.youtubeView)
                    }
                    else {
                        self.snapchatView.isHidden = false
                    }
                }
                else if key == "twitter" {
                    if  element["show"] == "hide" {
                        self.twitterView.isHidden = true
                        self.bumpUp(view: self.linkedinView)
                        self.bumpUp(view: self.soundcloudView)
                        self.bumpUp(view: self.youtubeView)
                    }
                    else {
                        self.twitterView.isHidden = false
                    }
                }
                else if key == "linkedin" {
                    if  element["show"] == "hide" {
                        self.linkedinView.isHidden = true
                        self.bumpUp(view: self.soundcloudView)
                        self.bumpUp(view: self.youtubeView)
                    }
                    else {
                        self.linkedinView.isHidden = false
                    }
                }
                else if key == "soundcloud" {
                    if element["show"] == "hide" {
                        self.soundcloudView.isHidden = true
                        self.bumpUp(view: self.youtubeView)
                    }
                    else {
                        self.soundcloudView.isHidden = false
                    }
                    
                }
                else if key == "youtube" {
                    if element["show"] == "hide" {
                        self.youtubeView.isHidden = true
                    }
                    else {
                        self.youtubeView.isHidden = false
                    }
                    
                }
            }
        })
        ref.child("privacy_settings").observeSingleEvent(of: .value, with: { snapshot in
            let settingsData = snapshot.value as! Dictionary<String, Dictionary<String, String>>
            for (key, element) in settingsData {
                if key == "facebook" {
                    if  element["show"] == "hide" {
                        self.facebookNameView?.textColor = UIColor.gray
                        self.facebookNameView?.text = "Private"
                    }
                    else {                        
                        self.facebookNameView?.textColor = UIColor.black
                        self.facebookNameView.text = self.profileInfo?.facebookName ?? "takaoandrew"
                    }
                }
                else if key == "instagram" {
                    if  element["show"] == "hide" {
                        self.instagramNameView?.textColor = UIColor.gray
                        self.instagramNameView?.text = "Private"
                    }
                    else {
                        self.instagramNameView?.textColor = UIColor.black
                        self.instagramNameView.text = self.profileInfo?.instagramName ?? "andrewtakao"
                    }
                }
                else if key == "snapchat" {
                    if  element["show"] == "hide" {
                        self.snapchatNameView?.textColor = UIColor.gray
                        self.snapchatNameView?.text = "Private"
                    }
                    else {
                        self.snapchatNameView?.textColor = UIColor.black
                        self.snapchatNameView.text = self.profileInfo?.snapchatName ?? "chocotako"
                    }
                }
                else if key == "twitter" {
                    if  element["show"] == "hide" {
                        self.twitterNameView?.textColor = UIColor.gray
                        self.twitterNameView?.text = "Private"
                    }
                    else {
                        self.twitterNameView?.textColor = UIColor.black
                        self.twitterNameView.text = self.profileInfo?.twitterName ?? "tweetakao"
                    }
                }
                else if key == "linkedin" {
                    if  element["show"] == "hide" {
                        self.linkedinNameView?.textColor = UIColor.gray
                        self.linkedinNameView?.text = "Private"
                    }
                    else {
                        self.linkedinNameView?.textColor = UIColor.black
                        self.linkedinNameView.text = self.profileInfo?.linkedinName ?? "Andrew Takao"
                    }
                }
                else if key == "soundcloud" {
                    if element["show"] == "hide" {
                        self.soundcloudNameView?.textColor = UIColor.gray
                        self.soundcloudNameView?.text = "Private"
                    }
                    else {
                        self.soundcloudNameView?.textColor = UIColor.black
                        self.soundcloudNameView.text = self.profileInfo?.soundcloudName ?? "Andrew Takao"
                    }
                    
                }
                else if key == "youtube" {
                    if element["show"] == "hide" {
                        self.youtubeNameView?.textColor = UIColor.gray
                        self.youtubeNameView?.text = "Private"
                    }
                    else {
                        self.youtubeNameView?.textColor = UIColor.black
                        self.youtubeNameView.text = self.profileInfo?.youtubeName ?? "Takao Productions"
                    }
                }
            }
        })
        view.bringSubview(toFront: facebookView)
        view.bringSubview(toFront: instagramView)
        view.bringSubview(toFront: snapchatView)
        view.bringSubview(toFront: twitterView)
        view.bringSubview(toFront: linkedinView)
        view.bringSubview(toFront: soundcloudView)
        view.bringSubview(toFront: youtubeView)
        
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
                    if element["show"] == "hide" {
                        self.bumpDown(view: self.instagramView)
                        self.bumpDown(view: self.snapchatView)
                        self.bumpDown(view: self.twitterView)
                        self.bumpDown(view: self.linkedinView)
                        self.bumpDown(view: self.soundcloudView)
                        self.bumpDown(view: self.youtubeView)
                    }
                }
                else if key == "instagram" {
                    if element["show"] == "hide" {
                        self.bumpDown(view: self.snapchatView)
                        self.bumpDown(view: self.twitterView)
                        self.bumpDown(view: self.linkedinView)
                        self.bumpDown(view: self.soundcloudView)
                        self.bumpDown(view: self.youtubeView)
                    }
                }
                else if key == "snapchat" {
                    if element["show"] == "hide" {
                        self.bumpDown(view: self.twitterView)
                        self.bumpDown(view: self.linkedinView)
                        self.bumpDown(view: self.soundcloudView)
                        self.bumpDown(view: self.youtubeView)
                    }
                }
                else if key == "twitter" {
                    if element["show"] == "hide" {
                        self.bumpDown(view: self.linkedinView)
                        self.bumpDown(view: self.soundcloudView)
                        self.bumpDown(view: self.youtubeView)
                    }
                }
                else if key == "linkedin" {
                    if element["show"] == "hide" {
                        self.bumpDown(view: self.soundcloudView)
                        self.bumpDown(view: self.youtubeView)
                    }
                }
                else if key == "soundcloud" {
                    if element["show"] == "hide" {
                        self.bumpDown(view: self.youtubeView)
                    }
                }
                else if key == "youtube" {
                    if element["show"] == "hide" {
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
    
    func soundcloudTapped(sender:UITapGestureRecognizer) {
        let soundcloudId = profileInfo?.soundcloudId ?? "andrew-takao"
        let soundcloudHooks = "soundcloud://profile/" + soundcloudId
        let soundcloudUrl = NSURL(string: soundcloudHooks)
        if UIApplication.shared.canOpenURL(soundcloudUrl! as URL)
        {
            UIApplication.shared.open(soundcloudUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://soundcloud.com/")! as URL, options: [:], completionHandler: nil)
        }
        //        apps.open(Applications.Linkedin(), action: .open)
    }
    
    func youtubeTapped(sender:UITapGestureRecognizer) {
        let youtubeId = profileInfo?.youtubeId ?? "Takao Productions"
        let youtubeHooks = "youtube://profile/" + youtubeId
        let youtubeUrl = NSURL(string: youtubeHooks)
        if UIApplication.shared.canOpenURL(youtubeUrl! as URL)
        {
            UIApplication.shared.open(youtubeUrl! as URL, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.open(NSURL(string: "http://youtube.com/")! as URL, options: [:], completionHandler: nil)
        }
        //        apps.open(Applications.Linkedin(), action: .open)
    }
    
    
    @IBAction func ConnectClicked(_ sender: Any) {
        ConnectButton.setTitle("Connected", for: .normal)
        ConnectButton.backgroundColor = UIColor.green
    }
    
    @IBAction func contactClicked(_ sender: Any) {
        contactInformation.isHidden = false
        contactView.isHidden = true
    }
    
    @IBAction func echoClicked(_ sender: Any) {
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toViewController = segue.destination as? EchoViewController {
            if segue.identifier == "echoSegue" {
                toViewController.profileInfo = self.profileInfo ?? defaultProfileInfo
            }
            
        }
    }
    
    

}
