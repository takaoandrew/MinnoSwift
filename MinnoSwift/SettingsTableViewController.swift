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
        
        
        settings = ["privacy settings [TRY ME]", "following", "push notifications", "change number", "terms of use", "data policy", "add or remove social media [TRY ME]"]
    }
    
    @IBAction func backButtonTapped(_ sender: Any) {        
        self.dismiss(animated: true, completion: nil)
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
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        if settings(indexPath)
        var clicked = ""
        let setting = settings?[indexPath.row]
        if let setting = setting {
            clicked = setting
        }
        switch(clicked) {
            case "privacy settings [TRY ME]":
                print("Success")
                self.performSegue(withIdentifier: "Trevor Profile", sender: self)
                return
            case "add or remove social media [TRY ME]":
                print("Sucess")
                self.performSegue(withIdentifier: "AddRemoveSegue", sender: self)
                return
            default:
                return
        }
    }
    
//    - (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
//    if ([[settingsData objectAtIndex:indexPath.row] isEqualToString:@"add or remove social media"]) {
//    NSLog(@"clicked the right one");
//    ProfilesVC* profilesVC = [[ProfilesVC alloc] init];
//    [self presentViewController:profilesVC animated:YES completion:nil];
//    
//    }
//    }
}
