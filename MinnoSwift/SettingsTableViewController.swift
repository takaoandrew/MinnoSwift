//
//  SettingsTableViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 6/25/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit

class SettingsTableViewController: UITableViewController {

    var settings: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        settings = ["privacy settings",
                    //"following [coming soon]",
//                    "push notifications [coming soon]",
                    "edit handles",
                    "terms of use [coming soon]",
                    "data policy [coming soon]",
                    "add or remove social media",
                    "sign out"]
    }
//    
//    @IBAction func backButtonTapped(_ sender: Any) {        
//        self.dismiss(animated: true, completion: nil)
//    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let settings = settings {
            return settings.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let setting = settings?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "SettingCell", for: indexPath)
        if let setting = setting {
            cell.textLabel?.text = setting
        }
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if settings(indexPath)
        var clicked = ""
        let setting = settings?[indexPath.row]
        if let setting = setting {
            clicked = setting
        }
        switch(clicked) {
            case "privacy settings":
                self.performSegue(withIdentifier: "PrivacySegue", sender: self)
                return
            case "add or remove social media":
                self.performSegue(withIdentifier: "AddRemoveSegue", sender: self)
                return
            case "sign out":
                self.performSegue(withIdentifier: "HomeSegue", sender: self)
                return
            default:
                return
        }
    }
}
