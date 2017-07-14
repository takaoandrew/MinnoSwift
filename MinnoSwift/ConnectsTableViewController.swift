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
        
        connects = ["Trevor Massey", "Johnny P", "Kim Song", "Tony Alvarez"]
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedProgram = "Trevo"
        
        // Create an instance of PlayerTableViewController and pass the variable
        let destinationVC = ProfileViewController()
        destinationVC.programVar = "Trevo"
        
        // Let's assume that the segue name is called playerSegue
        // This will perform the segue and pre-load the variable for you to use
        
        var clicked = ""
        let connect = connects?[indexPath.row]
        if let connect = connect {
            clicked = connect
        }
        switch(clicked) {
        case "Trevor Massey":
            print("Sucess")
            destinationVC.performSegue(withIdentifier: "trevorSegue", sender: self)
            return
        case "add or remove social media [TRY ME]":
            self.performSegue(withIdentifier: "AddRemoveSegue", sender: self)
            return
        default:
            return
        }
    }
    

}
