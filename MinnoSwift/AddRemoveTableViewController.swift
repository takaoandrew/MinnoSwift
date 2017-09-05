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

    private var newSettingRefHandle: DatabaseHandle?
    
    var media: [String] = []
    var showMedia: [String] = []
    var count: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        media = ["facebook", "instagram", "snapchat", "twitter", "linkedin", "soundcloud", "youtube"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return media.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        count = 0
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
                    self.count += 1
//                    print(self.count)
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
                if show == "show" {
                    let settingsItem = [
                        "media": self.media[indexPath.row],
                        "show": "hide"
                        ] as [String : Any]
                    tempRef.setValue(settingsItem)
                }
                else {
                    if self.count <= 5 {
                        let settingsItem = [
                            "media": self.media[indexPath.row],
                            "show": "show"
                            ] as [String : Any]
                        tempRef.setValue(settingsItem)
                    }
                    else {
                        let alertController = UIAlertController(title: "", message: "Please select 6 or less", preferredStyle: UIAlertControllerStyle.alert)
//                        let cancelAction = UIAlertAction(title: "Cancel", style: UIAlertActionStyle.cancel) { (result : UIAlertAction) -> Void in
//                            print("Cancel")
//                        }
                        let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                            print("OK")
                        }
//                        alertController.addAction(cancelAction)
                        alertController.addAction(okAction)
                        self.present(alertController, animated: true, completion: nil)
                    }
                    
                }
            }
            self.tableView.reloadData()
        })
    }

}
