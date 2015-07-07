//
//  Channel.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

enum stateType : CustomStringConvertible{
    case Connected
    case Unconnected
    var description:String{
        switch self{
        case .Connected: return "Connected";
        case .Unconnected: return "Unconnected";
        }
    }
}

struct AIChannel {
    var name: String
    var unreadCount:Int
    var channelState: stateType
    var description: String{
        return "ChannelName: \(name) \nState: \(channelState.description) \nUnread: \(unreadCount)"
    }
    mutating func changeName(name: String){
        self.name = name
    }
}