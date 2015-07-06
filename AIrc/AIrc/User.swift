//
//  User.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation


struct AIUser {
    var name:String
    var nickname:String
    var description: String{
        return "\(name) \(nickname)"
    }
}