//
//  TableViewCell.swift
//  AIrc
//
//  Created by Tim Harris on 7/18/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation
import UIKit

class AIServerTableCellView: UITableViewCell {
    var swiped:Bool = false
    @IBOutlet weak var nameLabel: UILabel!
    
}

class AIChannelTableCellView: UITableViewCell {
    @IBOutlet weak var unreadCountLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    
}
