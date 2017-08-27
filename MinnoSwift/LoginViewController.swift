//
//  LoginViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 8/8/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {

    @IBOutlet weak var NameField: UITextField!
    
    var connect: Connect?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let dismissKeyboardTap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(LoginViewController.dismissKeyboard))
        
        view.addGestureRecognizer(dismissKeyboardTap)
        
        // Do any additional setup after loading the view.
    }

    @IBAction func LoginPressed(_ sender: Any) {
        let name = NameField.text!
        let userRef = Database.database().reference().child("users")
        userRef.observeSingleEvent(of: .value, with: { snapshot in
            if snapshot.hasChild(name) {
                let tempRef = userRef.child(name)
                tempRef.observeSingleEvent(of: .value, with: { snapshot in
                    let currentUser = snapshot.value as! Dictionary<String, String>
                    print("currentUserName")
                    print(currentUser["name"]!)
                    self.connect = Connect(
                        name: currentUser["name"]!,
                        email: currentUser["email"]!,
                        phone: currentUser["phone"]!,
                        facebookName: currentUser["facebookName"]!,
                        facebookId: currentUser["facebookId"]!,
                        instagramName: currentUser["instagramName"]!,
                        instagramId: currentUser["instagramId"]!,
                        snapchatName: currentUser["snapchatName"]!,
                        snapchatId: currentUser["snapchatId"]!,
                        twitterName: currentUser["twitterName"]!,
                        twitterId: currentUser["twitterId"]!,
                        linkedinName: currentUser["linkedinName"]!,
                        linkedinId: currentUser["linkedinId"]!,
                        soundcloudName: currentUser["soundcloudName"]!,
                        soundcloudId: currentUser["soundcloudId"]!,
                        youtubeName: currentUser["youtubeName"]!,
                        youtubeId: currentUser["youtubeId"]!)
                    
                    self.performSegue(withIdentifier: "login", sender: self)
                })
            }
            else {
                let alertController = UIAlertController(title: "", message: "That name was not found in the database", preferredStyle: UIAlertControllerStyle.alert)
                let okAction = UIAlertAction(title: "OK", style: UIAlertActionStyle.default) { (result : UIAlertAction) -> Void in
                    print("OK")
                }
                alertController.addAction(okAction)
                self.present(alertController, animated: true, completion: nil)
            }
        })
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "login" {
            if let toViewController = segue.destination as? ProfileViewController {
                toViewController.profileInfo = self.connect
                
            }
        }
    }
    
    func dismissKeyboard() {
        view.endEditing(true)
    }

}
