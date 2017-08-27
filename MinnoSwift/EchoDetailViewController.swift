//
//  EchoDetailViewController.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 8/26/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit
import MapKit

class EchoDetailViewController: UIViewController {
    
    var echoInfo : Echo?
    var profileInfo : Connect?
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var hostLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        
        titleLabel.text = echoInfo?.title
        if echoInfo?.privacy == "Private" {
            titleLabel.text = titleLabel.text! + " (Private)"
        }
        hostLabel.text = echoInfo?.host
        descriptionLabel.text = echoInfo?.eventDescription
    }


}
