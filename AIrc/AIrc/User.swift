//
//  User.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation


struct AIUser {
    var name:String //User name
    var nickname:String // Nickname for user
    var description: String{ //description for user
        return "\(name) \(nickname)"
    }
}