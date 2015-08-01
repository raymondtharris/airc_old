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
    case Disconnected // disconnected state
    case Reconnecting // reconnecting state
    case Connecting // connecting state
    var description:String{ // description variable
        switch self{
        case .Connected: return "Connected";
        case .Unconnected: return "Unconnected";
        case .Disconnected: return "Disconnected";
        case .Reconnecting: return "Reconnecting";
        case .Connecting: return "Connecting";
        }
    }
}


struct AIChannel {
    var name: String // Name of the channel
    var unreadCount:Int // Unread count of the channel
    var connection:NSURLSession // Session for channel
    var channelState: stateType // State of the channel
    var mediaLibrary:[AIMedia] // Array of media found on the channel
    var autoReconnect:Bool //Recoonect to server automatically
    var description: String{ // Description of the channel
        return "ChannelName: \(name) \nState: \(channelState.description) \nUnread: \(unreadCount)"
    }
    init(name:String){
        self.name = name
        self.unreadCount = 0
        self.connection = NSURLSession.sharedSession()
        self.channelState = stateType.Unconnected
        self.mediaLibrary = [AIMedia]()
        self.autoReconnect = false
    }
    init(name:String, unreadCount: Int, channelState:stateType, autoReconnect: Bool){
        self.name = name
        self.unreadCount = unreadCount
        self.connection = NSURLSession.sharedSession()
        self.channelState = channelState
        self.mediaLibrary = [AIMedia]()
        self.autoReconnect = autoReconnect
    }
    
    mutating func setName(name: String){ // Changes the name of the channel
        self.name = name
    }
    mutating func setUnreadCount(unreadCount: Int){
        self.unreadCount = unreadCount
    }
    mutating func setAutoReconnect(autoReconnect: Bool){
        self.autoReconnect = autoReconnect
    }
}