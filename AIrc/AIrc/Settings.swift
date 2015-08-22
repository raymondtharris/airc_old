//
//  Settings.swift
//  AIrc
//
//  Created by Tim Harris on 7/11/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

class ClientStettings: NSObject, NSCoding{
    var name:String
    var useSameName:Bool
    var nickName:String
    var useSameNickname:Bool
    var saveMediaLength:Int
    var useSaveMediaLength:Bool
    
    var reconnectToServersOnOpen:Bool
    var reconnectToChannelsOnOpen:Bool
    
    override var description: String{
        return "name: \(name) \(useSameName) nickname: \(nickName) \(useSameNickname)"
    }
    
    override init(){
        self.name = "Test"
        self.useSameName = true
        self.nickName = self.name
        self.useSameNickname = true
        self.saveMediaLength = 4
        self.useSaveMediaLength = true
        self.reconnectToServersOnOpen = true
        self.reconnectToChannelsOnOpen = false
    }
    init(settings:ClientStettings){
        self.name = settings.name
        self.useSameName = settings.useSameName
        self.nickName = settings.nickName
        self.useSameNickname = settings.useSameNickname
        self.saveMediaLength = settings.saveMediaLength
        self.useSaveMediaLength = settings.useSaveMediaLength
        self.reconnectToServersOnOpen = settings.reconnectToServersOnOpen
        self.reconnectToChannelsOnOpen = settings.reconnectToChannelsOnOpen

    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.useSameName, forKey: "useSameName")
        aCoder.encodeObject(self.nickName, forKey: "nickName")
        aCoder.encodeObject(self.useSameNickname, forKey: "useSameNickname")
        aCoder.encodeObject(self.saveMediaLength, forKey: "saveMediaLength")
        aCoder.encodeObject(self.useSaveMediaLength, forKey: "useSaveMediaLength")
        aCoder.encodeObject(self.reconnectToServersOnOpen, forKey: "reconnectToServerOnOpen")
        aCoder.encodeObject(self.reconnectToChannelsOnOpen, forKey: "reconnectToChannelOnOpen")
    }
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.useSameName = aDecoder.decodeObjectForKey("useSameName") as! Bool
        self.nickName = aDecoder.decodeObjectForKey("nickName") as! String
        self.useSameNickname = aDecoder.decodeObjectForKey("useSameNickname") as! Bool
        self.saveMediaLength = aDecoder.decodeObjectForKey("saveMediaLength") as! Int
        self.useSaveMediaLength = aDecoder.decodeObjectForKey("useSaveMediaLength") as! Bool
        self.reconnectToServersOnOpen = aDecoder.decodeObjectForKey("reconnectToServersOnOpen") as! Bool
        self.reconnectToChannelsOnOpen = aDecoder.decodeObjectForKey("recconectToChannelsOnOpen") as! Bool
    }
}