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
    var email : String
    var phone : String
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
    var soundcloudName : String
    var soundcloudId : String
    var youtubeName : String
    var youtubeId : String
    
    init(name: String, email: String, phone: String, facebookName: String, facebookId: String,
         instagramName: String, instagramId: String, snapchatName: String, snapchatId: String,
         twitterName: String, twitterId: String, linkedinName: String, linkedinId: String,
         soundcloudName: String, soundcloudId: String, youtubeName: String, youtubeId: String) {
        self.name = name
        self.email = email
        self.phone = phone
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
        self.soundcloudName = soundcloudName
        self.soundcloudId = soundcloudId
        self.youtubeName = youtubeName
        self.youtubeId = youtubeId
        
    }

}
