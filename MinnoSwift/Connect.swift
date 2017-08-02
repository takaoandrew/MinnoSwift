//
//  Connect.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 7/27/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit

class Connect: NSObject {
    var name : String
    var picture : UIImage
    var facebookName : String
    var facebookId : String
    var instagramName : String
    var instagramId : String
    var snapchatName : String
    var snapchatId : String
    var twitterName : String
    var twitterId : String
    var linkedinName : String
    var linkedinId : String
    
    init(name: String, picture: UIImage, facebookName: String, facebookId: String,
         instagramName: String, instagramId: String, snapchatName: String, snapchatId: String,
         twitterName: String, twitterId: String, linkedinName: String, linkedinId: String) {
        self.name = name
        self.picture = picture
        self.facebookName = facebookName
        self.facebookId = facebookId
        self.instagramName = instagramName
        self.instagramId = instagramId
        self.snapchatName = snapchatName
        self.snapchatId = snapchatId
        self.twitterName = twitterName
        self.twitterId = twitterId
        self.linkedinName = linkedinName
        self.linkedinId = linkedinId
        
    }

}
