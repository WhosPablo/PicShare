//
//  CatsTableViewCell.swift
//  Paws
//
//  Created by Simon Ng on 15/4/15.
//  Copyright (c) 2015 AppCoda. All rights reserved.
//

import UIKit
import ParseUI
import Parse

class PhotoTableViewCell: PFTableViewCell {
    
    @IBOutlet weak var photoImageView:UIImageView?
    @IBOutlet weak var userNameLabel:UILabel?

    var parseObject:PFObject?
    
    override func awakeFromNib() {
        
        super.awakeFromNib()
    }
    
}
