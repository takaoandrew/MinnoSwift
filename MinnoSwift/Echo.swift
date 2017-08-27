//
//  Echo.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 8/26/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit

class Echo: NSObject {
    var title : String
    var privacy : String
    var host : String
    var eventDescription : String
    var location : String
    
    init(title: String, privacy: String, host: String, eventDescription: String, location: String) {
        self.title = title
        self.privacy = privacy
        self.host = host
        self.eventDescription = eventDescription
        self.location = location
    }
    
}
