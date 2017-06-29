//
//  AddRemoveTableViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 6/25/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit

class AddRemoveTableViewController: UITableViewController {

    var media: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        media = ["facebook", "instagram", "snapchat", "twitter", "linkedin"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let media = media {
            return media.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let media = self.media?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "AddRemoveCell", for: indexPath)
        if let media = media {
            cell.textLabel?.text = media
        }
        return cell
    }

}
