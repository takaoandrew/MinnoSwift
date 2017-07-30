//
//  AddRemoveTableViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 6/25/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit
import Firebase

class AddRemoveTableViewController: UITableViewController {

//    let ref = Database.database().reference(withPath: "add_remove_settings")
    private var newSettingRefHandle: DatabaseHandle?
    
    var media: [String] = []
    var showMedia: [String] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        media = ["facebook", "instagram", "snapchat", "twitter", "linkedin"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let media = self.media[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddRemoveCell", for: indexPath)
        cell.textLabel?.text = media
        let ref = Database.database().reference()
        ref.child("add_remove_settings").child(media).observeSingleEvent(of: .value, with: { snapshot in
            let settingsData = snapshot.value as! Dictionary<String, String>
            if let id = settingsData["show"] as String! {
                if id == "show" {
                    cell.detailTextLabel?.text = id
                    cell.backgroundColor = UIColor.red
                }
                else {
                    cell.detailTextLabel?.text = id
                    cell.backgroundColor = UIColor.blue
                }
            }
        })
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let currentMedia = self.media[indexPath.row]
        let tempRef = Database.database().reference().child("add_remove_settings").child(currentMedia)
        tempRef.observeSingleEvent(of: .value, with: { snapshot in
            let currentData = snapshot.value as! Dictionary<String, String>
            if let show = currentData["show"] as String! {
                print("show is " + show)
                if show == "show" {
                    let settingsItem = [
                        "media": self.media[indexPath.row],
                        "show": "hide"
                        ] as [String : Any]
                    tempRef.setValue(settingsItem)
                }
                else {
                    let settingsItem = [
                        "media": self.media[indexPath.row],
                        "show": "show"
                        ] as [String : Any]
                    tempRef.setValue(settingsItem)
                }
            }
            self.tableView.reloadData()
        })
    }

}
