//
//  ConnectsTableViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 6/25/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit

extension ConnectsTableViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        filterContentForSearchText(searchText: searchController.searchBar.text!)
    }
    
}

extension ConnectsTableViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, selectedScopeButtonIndexDidChange selectedScope: Int) {
        filterContentForSearchText(searchText: searchBar.text!, scope: searchBar.scopeButtonTitles![selectedScope])
    }
}

class ConnectsTableViewController: UITableViewController {
    
    let searchController = UISearchController(searchResultsController: nil)
    
    var connects = [Connect]()
    var filteredConnects = [Connect]()
    
    func filterContentForSearchText(searchText: String, scope: String = "All") {
        filteredConnects = connects.filter { connect in
            return  connect.name.lowercased().contains(searchText.lowercased())
        }
        
        tableView.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        connects = [
            Connect(name:"Trevor Massey", picture:(#imageLiteral(resourceName: "avatar"))),
            Connect(name:"Andrew Takao", picture:(#imageLiteral(resourceName: "avatar"))),
            Connect(name:"John Smith", picture:(#imageLiteral(resourceName: "avatar"))),
//            Connect(name:"Pete Holmes", picture:UIImage(named: "profile3.jpg")!),
//            Connect(name:"Jake Walker", picture:UIImage(named: "profile3.jpg")!),
            Connect(name:"Mark Peters", picture:(#imageLiteral(resourceName: "avatar")))
        ]
        searchController.searchResultsUpdater = self as? UISearchResultsUpdating
        searchController.dimsBackgroundDuringPresentation = false
        definesPresentationContext = true
        tableView.tableHeaderView = searchController.searchBar
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searchController.isActive && searchController.searchBar.text != "" {
            return filteredConnects.count
        }
        else {
            return connects.count
        }
    }
    
//    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectionCell", for: indexPath)
//        let connection: Connection
//        if searchController.isActive && searchController.searchBar.text != "" {
//            connection = filteredConnections[indexPath.row]
//        }
//        else {
//            connection = connections[indexPath.row]
//        }
//        cell.textLabel!.text = connection.name
//        cell.detailTextLabel?.text = connection.group
//        
//        return cell
//    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ConnectCell", for: indexPath)
        let connect: Connect
        if searchController.isActive && searchController.searchBar.text != "" {
            connect = filteredConnects[indexPath.row]
        }
        else {
            connect = connects[indexPath.row]
        }
        cell.textLabel!.text = connect.name
        cell.imageView?.image = UIImage(named: "profile3.jpg")
        
        return cell
    }
    
//    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
////        let selectedProgram = "Trevo"
//        
//        // Create an instance of PlayerTableViewController and pass the variable
//        let destinationVC = ProfileViewController()
//        destinationVC.programVar = "Trevo"
//        
//        // Let's assume that the segue name is called playerSegue
//        // This will perform the segue and pre-load the variable for you to use
//        
//        var clicked = ""
//        let connect = connects?[indexPath.row]
//        if let connect = connect {
//            clicked = connect
//        }
//        switch(clicked) {
//        case "Trevor Massey":
//            print("Sucess")
//            destinationVC.performSegue(withIdentifier: "trevorSegue", sender: self)
//            return
//        case "add or remove social media [TRY ME]":
//            self.performSegue(withIdentifier: "AddRemoveSegue", sender: self)
//            return
//        default:
//            return
//        }
//    }
    

}
