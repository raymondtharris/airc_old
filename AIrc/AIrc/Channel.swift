//
//  Channel.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

enum stateType : CustomStringConvertible{
    case Connected //connected state
    case Unconnected // unconnected state
    var description:String{ // description variable
        switch self{
        case .Connected: return "Connected";
        case .Unconnected: return "Unconnected";
        }
    }
}

protocol Convenience{
    func connect()
    func disconnect()
}


struct AIChannel: Convenience {
    var name: String // Name of the channel
    var unreadCount:Int // Unread count of the channel
    var channelState: stateType // State of the channel
    var mediaLibrary:[AIMedia] // Array of media found on the channel
    var autoReconnect:Bool //Recoonect to server automatically
    var description: String{ // Description of the channel
        return "ChannelName: \(name) \nState: \(channelState.description) \nUnread: \(unreadCount)"
    }
    mutating func changeName(name: String){ // Changes the name of the channel
        self.name = name
    }
    
    func connect() {
        
    }
    func disconnect() {
        
    }
}