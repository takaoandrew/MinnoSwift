//
//  SearchTableViewCell.swift
//  MinnoSwift
//
//  Created by Andrew Takao on 9/9/17.
//  Copyright © 2017 Andrew Takao. All rights reserved.
//

import UIKit

class SearchTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    // Here you can customize the appearance of your cell
    override func layoutSubviews() {
        super.layoutSubviews()
        // Customize imageView like you need
        self.imageView?.frame = CGRect(x: 10, y: 0, width: 40, height: 40)
        self.imageView?.contentMode = UIViewContentMode.scaleAspectFit
        // Costomize other elements
        self.textLabel?.frame = CGRect(x: 80, y: (self.frame.height-20)/2, width: self.frame.width - 45, height: 20)
    }

}
