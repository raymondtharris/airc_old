//
//  Server.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

struct AIServer {
    var name:String
    var port:Int
    var address:String
    var connectedChannels:[AIChannel]
    var user:AIUser
    
    mutating func addChannel(channel:AIChannel){
        connectedChannels.append(channel)
    }
    mutating func updateUser(userData:AIUser){
        user = userData
    }
}
