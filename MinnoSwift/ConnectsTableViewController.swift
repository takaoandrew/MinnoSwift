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
            Connect(name:"Trevor Massey", email: "trevmass@gmail.com", phone: "123-456-7890",
            facebookName: "trevor massey", facebookId: "1565426905",
            instagramName: "trev_mass", instagramId: "trev_mass", snapchatName: "tmass9", snapchatId: "tmass9",
            twitterName: "trev_mass", twitterId: "trev_mass", linkedinName: "trev_mass", linkedinId: "trev_mass",
            soundcloudName: "trev_mass", soundcloudId: "trev_mass", youtubeName: "trev_mass", youtubeId: "trev_mass"),
            Connect(name:"Andrew Takao", email: "takaoandrew@gmail.com", phone: "631-398-9782",
            facebookName: "Andrew Takao", facebookId: "661299413",
            instagramName: "chocotako1", instagramId: "chocotako1", snapchatName: "chocotako", snapchatId: "chocotako",
            twitterName: "trev_mass", twitterId: "trev_mass", linkedinName: "andrew-takao", linkedinId: "andrew-takao",
            soundcloudName: "trev_mass", soundcloudId: "trev_mass", youtubeName: "Takao productions", youtubeId: "trev_mass")
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
        cell.imageView?.image = #imageLiteral(resourceName: "avatar")
        
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let selectedProgram = "Trevo"
        
//        let destinationVC = ProfileViewController()
//        destinationVC.programVar = "Trevo"
        
        // Let's assume that the segue name is called playerSegue
        // This will perform the segue and pre-load the variable for you to use
        
        let connect = connects[indexPath.row]
//        if let connect = connect {
//            clicked = connect
//        }
        if connect.name == "Trevor Massey" {
            print("Success")
            self.performSegue(withIdentifier: "trevorSegue", sender: self)
        }
        return
    }
    
    
    //Clicking Trevor redirects to his profile
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "trevorSegue" {
            if let toViewController = segue.destination as? ProfileViewController {
                toViewController.profileInfo = connects[0]
            }
        }
    }
    

}
