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
        settings = ["your info and linked accounts", "following", "push notifications", "change number",
        "help center", "give feedback", "terms of use", "data policy", "add or remove social media"]
    }
    
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
}
