//
//  ConnectsTableViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 6/25/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit

class ConnectsTableViewController: UITableViewController {

    var connects: [String]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        connects = ["Jim Jones", "Johnny P", "Kim Song", "Tony Alvarez"]
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let connects = connects {
            return connects.count
        }
        return 0
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let connect = connects?[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectCell", for: indexPath)
        if let connect = connect {
            cell.textLabel?.text = connect
            cell.imageView?.image = UIImage(named: "profile3.jpg")
        }
        return cell
    }
    

}
