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
    
    var ref:DatabaseReference?
    
    lazy var profilePictureViewController: ProfilePictureViewController = {
        let storyboard = UIStoryboard(name: "5s", bundle: Bundle.main)
        
        var profilePictureController = storyboard.instantiateViewController(withIdentifier: "ProfilePictureViewController") as! ProfilePictureViewController
        var profilePictureViewFrame: CGRect
        if self.view.bounds.size.height >= 580 {
            profilePictureViewFrame = CGRect(x:10, y:105, width:109, height:118)
        }
        else {
//                        print("small picture")
            profilePictureViewFrame = CGRect(x:15, y:110, width:50, height:50)
        }
        self.addViewControllerAsChildViewController(childViewController: profilePictureController, cGRect: profilePictureViewFrame)
        return profilePictureController
    }()
    
    let apps = UIApplication.shared
    
    var defaultProfileInfo = Connect(name: "Test Name", email: "TestEmail", phone: "Test Phone", facebookName: "", facebookId: "", instagramName: "", instagramId: "", snapchatName: "", snapchatId: "", twitterName: "", twitterId: "", linkedinName: "", linkedinId: "", soundcloudName: "", soundcloudId: "", youtubeName: "", youtubeId: "", profileImage: "myImage.png")
    
    var profileInfo : Connect?
    var privacyInfo : Connect?
    var connectFromList : Connect?
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var connects = [Connect]()
    var filteredConnects = [Connect]()
    
    @IBOutlet weak var connectTableView: UITableView!
    @IBOutlet weak var searchBar: UISearchBar!
    
    @IBOutlet weak var phoneNameView: UILabel!
    @IBOutlet weak var nameView: UILabel!
    @IBOutlet weak var facebookNameView: UILabel!
    @IBOutlet weak var instagramNameView: UILabel!
    @IBOutlet weak var snapchatNameView: UILabel!
    @IBOutlet weak var twitterNameView: UILabel!
    @IBOutlet weak var linkedinNameView: UILabel!
    @IBOutlet weak var soundcloudNameView: UILabel!
    @IBOutlet weak var youtubeNameView: UILabel!
 
    @IBOutlet weak var connectView: UIButton!
    
    @IBOutlet weak var phoneView: UIView!
    @IBOutlet weak var facebookView: UIView!
    @IBOutlet weak var instagramView: UIView!
    @IBOutlet weak var snapchatView: UIView!
    @IBOutlet weak var twitterView: UIView!
    @IBOutlet weak var linkedinView: UIView!
    @IBOutlet weak var soundcloudView: UIView!
    @IBOutlet weak var youtubeView: UIView!
    
    @IBOutlet weak var ConnectButton: UIButton!
//    @IBOutlet weak var profilePictureContainerView: UIView!
    
    
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
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ConnectCell", for: indexPath) as! SearchTableViewCell
        cell.imageView!.layer.cornerRadius = 20
//        cell.imageView!.clipsToBounds = true
        let connect: Connect
        if searchController.isActive && searchController.searchBar.text != "" {
            connect = filteredConnects[indexPath.row]
        }
        else {
            connect = connects[indexPath.row]
        }
        cell.textLabel!.text = connect.name
        
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        let imageRef = storageRef.child(cell.textLabel!.text!+".png")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.getData(maxSize: 10 * 10024 * 10024) { data, error in
            if error == nil {
                // Data for "images/island.jpg" is returned
                let image = UIImage(data: data!)
                cell.imageView?.image = image
            }
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell: SearchTableViewCell = tableView.dequeueReusableCell(withIdentifier: "ConnectCell", for: indexPath) as! SearchTableViewCell
        let name = cell.textLabel?.text
        self.connectFromList = defaultProfileInfo
        let userRef = Database.database().reference().child("users")
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.hasChild(name!) {
                let tempRef = userRef.child(name!)
                tempRef.observeSingleEvent(of: .value, with: { snapshot in
                    let currentUser = snapshot.value as! Dictionary<String, String>
                    self.connectFromList = Connect(
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
                        youtubeId: currentUser["youtubeId"]!,
                        profileImage: currentUser["profileImage"]!)
                    
                    self.performSegue(withIdentifier: "view", sender: self)
                })
            }
            else {
                let alertController = UIAlertController(title: "", message: "That name was not found in the database", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
        return
    }
    
    func uploadMedia(completion: @escaping (_ url: String?) -> Void) {
        print("upload media running")
        let storageRef = Storage.storage().reference().child((profileInfo?.profileImage)!)
        let profilePicture = profilePictureViewController.imageView.image
        var finalPicture = #imageLiteral(resourceName: "soundcloud")
        if (profilePicture != nil) {
            finalPicture = profilePicture!
        }
        if let uploadData = UIImageJPEGRepresentation(finalPicture, 0.2)
        {
            storageRef.putData(uploadData, metadata: nil) { (metadata, error) in
                if error != nil {
                    print("error")
                    completion(nil)
                } else {
                    print("successfully uploaded")
                    completion((metadata?.downloadURL()?.absoluteString)!)
                    // your uploaded photo url.
                }
            }
        }
        else {
            print("could not get representation")
        }
    }
    
    func getConnect() {
        //return connect from current user
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        phoneView.layer.borderWidth = 2
        phoneView.layer.borderColor = UIColor.black.cgColor
        facebookView.layer.borderWidth = 2
        facebookView.layer.borderColor = UIColor.black.cgColor
        instagramView.layer.borderWidth = 2
        instagramView.layer.borderColor = UIColor.black.cgColor
        snapchatView.layer.borderWidth = 2
        snapchatView.layer.borderColor = UIColor.black.cgColor
        twitterView.layer.borderWidth = 2
        twitterView.layer.borderColor = UIColor.black.cgColor
        linkedinView.layer.borderWidth = 2
        linkedinView.layer.borderColor = UIColor.black.cgColor
        soundcloudView.layer.borderWidth = 2
        soundcloudView.layer.borderColor = UIColor.black.cgColor
        youtubeView.layer.borderWidth = 2
        youtubeView.layer.borderColor = UIColor.black.cgColor
        
        var names = [String]()
        let userRef = Database.database().reference().child("users")
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            let allUsers = snapshot.value as! Dictionary<String, Dictionary<String, String>>
            for name in allUsers {
                names.append(name.key)
            }
            
            for _ in snapshot.children {
                let tempRef = userRef.child(names.popLast()!)
                tempRef.observeSingleEvent(of: .value, with: { snapshot in
                    let currentUser = snapshot.value as! Dictionary<String, String>
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
                        youtubeId: currentUser["youtubeId"]!,
                        profileImage: currentUser["profileImage"]!))
                })
            }

        })
        
        connectTableView.backgroundColor = UIColor.clear
        
        searchController.hidesNavigationBarDuringPresentation = false
        searchController.searchResultsUpdater = self
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        connectTableView.tableHeaderView = searchController.searchBar
        
        phoneNameView.text = profileInfo?.phone ?? "631-398-9782"
        nameView.text = profileInfo?.name ?? "Andrew Takao"
        
        facebookNameView.text = profileInfo?.facebookName ?? "takaoandrew"
        instagramNameView.text = profileInfo?.instagramName ?? "andrewtakao"
        snapchatNameView.text = profileInfo?.snapchatName ?? "chocotako"
        twitterNameView.text = profileInfo?.twitterName ?? "tweetakao"
        linkedinNameView.text = profileInfo?.linkedinName ?? "Andrew Takao"
        soundcloudNameView.text = profileInfo?.soundcloudName ?? "Andrew Takao"
        youtubeNameView.text = profileInfo?.youtubeName ?? "Takao Productions"
        
        let phoneTap = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.phoneTapped(sender:)))
        phoneView.addGestureRecognizer(phoneTap)
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
        
//        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(ProfileViewController.dismissKeyboard))
//        view.addGestureRecognizer(dismissKeyboardTap)
//        connectTableView.removeGestureRecognizer(dismissKeyboardTap)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(ProfileViewController.keyboardWillDisappear), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        
        searchBar.delegate = self
        connectTableView.delegate = self
        connectTableView.dataSource = self
        view.bringSubview(toFront: ConnectButton)
        
        // Get a reference to the storage service using the default Firebase App
        let storage = Storage.storage()
        
        // Create a storage reference from our storage service
        let storageRef = storage.reference()
        let imageRef = storageRef.child((profileInfo?.profileImage)!)
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        imageRef.getData(maxSize: 10 * 10024 * 10024) { data, error in
            if error == nil {
                let image = UIImage(data: data!)
                self.profilePictureViewController.imageView.image = image
            }
        }
    }
    
    @IBAction func Echo(_ sender: Any) {
        keyboardWillShow()
    }
    
    @IBAction func Hide(_ sender: Any) {
        keyboardWillDisappear()
    }
    
    func keyboardWillShow() {
        profilePictureViewController.view.isHidden = true
        view.sendSubview(toBack: ConnectButton)
    }
    
    func keyboardWillDisappear() {
        view.bringSubview(toFront: ConnectButton)
        profilePictureViewController.view.isHidden = false
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
        print("Here are some dimensions")
        print(searchController.view.frame.origin.y)
        print(connectTableView.frame.origin.y)
//        print("view will appear")
        let profilePicture = profilePictureViewController.imageView?.image
        
        if (profilePicture != nil) {
            print("picture exists")
        }
        else {
            print("picture doesn't exist")
        }
    
        uploadMedia() { url in
            if url != nil {
                self.ref?.child("Posts").childByAutoId().setValue([
                    "newurl" : url!
                    ])
            }
        }
        
        let ref = Database.database().reference()
        ref.child("add_remove_settings").observeSingleEvent(of: .value, with: { snapshot in
            let settingsData = snapshot.value as! Dictionary<String, Dictionary<String, String>>
            for (key, element) in settingsData {
                if key == "facebook" {
                    if element["show"] == "hide" {
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
        print("before privacty")
        
        ref.child("privacy_settings").observeSingleEvent(of: .value, with: { snapshot in
            let settingsData = snapshot.value as! Dictionary<String, Dictionary<String, String>>
            for (key, element) in settingsData {
                if key == "facebook" {
                    if  element["show"] == "private" {
                        print("facebook private")
                        self.facebookNameView?.textColor = UIColor.gray
                        self.facebookNameView?.text = "Private"
                    }
                    else {
                        print("facebook public")
                        self.facebookNameView?.textColor = UIColor.black
                        self.facebookNameView.text = self.profileInfo?.facebookName ?? "takaoandrew"
                    }
                }
                else if key == "instagram" {
                    if  element["show"] == "private" {
                        self.instagramNameView?.textColor = UIColor.gray
                        self.instagramNameView?.text = "Private"
                    }
                    else {
                        self.instagramNameView?.textColor = UIColor.black
                        self.instagramNameView.text = self.profileInfo?.instagramName ?? "andrewtakao"
                    }
                }
                else if key == "snapchat" {
                    if  element["show"] == "private" {
                        self.snapchatNameView?.textColor = UIColor.gray
                        self.snapchatNameView?.text = "Private"
                    }
                    else {
                        self.snapchatNameView?.textColor = UIColor.black
                        self.snapchatNameView.text = self.profileInfo?.snapchatName ?? "chocotako"
                    }
                }
                else if key == "twitter" {
                    if  element["show"] == "private" {
                        self.twitterNameView?.textColor = UIColor.gray
                        self.twitterNameView?.text = "Private"
                    }
                    else {
                        self.twitterNameView?.textColor = UIColor.black
                        self.twitterNameView.text = self.profileInfo?.twitterName ?? "tweetakao"
                    }
                }
                else if key == "linkedin" {
                    if  element["show"] == "private" {
                        self.linkedinNameView?.textColor = UIColor.gray
                        self.linkedinNameView?.text = "Private"
                    }
                    else {
                        self.linkedinNameView?.textColor = UIColor.black
                        self.linkedinNameView.text = self.profileInfo?.linkedinName ?? "Andrew Takao"
                    }
                }
                else if key == "soundcloud" {
                    if element["show"] == "private" {
                        self.soundcloudNameView?.textColor = UIColor.gray
                        self.soundcloudNameView?.text = "Private"
                    }
                    else {
                        self.soundcloudNameView?.textColor = UIColor.black
                        self.soundcloudNameView.text = self.profileInfo?.soundcloudName ?? "Andrew Takao"
                    }
                    
                }
                else if key == "youtube" {
                    if element["show"] == "private" {
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
    
    func phoneTapped(sender:UITapGestureRecognizer) {
        print("PHONE")
        guard let number = URL(string: "tel://" + phoneNameView.text!) else { return }
//        let telephoneURL = "tel://" + phoneNameView.text!
        UIApplication.shared.open(number, options: [:], completionHandler: nil)
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
        print("clickedconnect")
        ConnectButton.setTitle("Connected", for: .normal)
        ConnectButton.backgroundColor = UIColor.green
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let toViewController = segue.destination as? ProfileViewController {
            toViewController.profileInfo = self.connectFromList
        }
    }
    

}
