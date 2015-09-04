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


class AIChannel:NSObject, NSCoding {
    var name: String // Name of the channel
    var unreadCount:Int // Unread count of the channel
    var channelState: stateType // State of the channel
    var mediaLibrary:[AIMedia] // Array of media found on the channel
    var autoReconnect:Bool //Recoonect to server automatically
    
    var inputStream:NSInputStream = NSInputStream() //Input from channel
    var outputStream:NSOutputStream = NSOutputStream() // Out to the channel
    
    override var description: String{ // Description of the channel
        return "ChannelName: \(name) \nState: \(channelState.description) \nUnread: \(unreadCount)"
    }
    init(name:String){
        self.name = name
        self.unreadCount = 0
        self.channelState = stateType.Unconnected
        self.mediaLibrary = [AIMedia]()
        self.autoReconnect = false
    }
    init(name:String, unreadCount: Int, channelState:stateType, autoReconnect: Bool){
        self.name = name
        self.unreadCount = unreadCount
        self.channelState = channelState
        self.mediaLibrary = [AIMedia]()
        self.autoReconnect = autoReconnect
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.unreadCount, forKey: "unreadCount")
        aCoder.encodeObject(self.mediaLibrary, forKey: "mediaLibrary")
        aCoder.encodeObject(self.channelState.description, forKey: "channelState")
        aCoder.encodeObject(self.autoReconnect, forKey: "autoReconnect")
    }
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.unreadCount = aDecoder.decodeObjectForKey("unreadCount") as! Int
        self.channelState = aDecoder.decodeObjectForKey("channelState") as! stateType
        self.mediaLibrary = aDecoder.decodeObjectForKey("mediaLibrary") as! [AIMedia]
        self.autoReconnect = aDecoder.decodeObjectForKey("autoReconnect") as! Bool
    }
}