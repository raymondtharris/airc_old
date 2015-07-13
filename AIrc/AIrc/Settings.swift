//
//  Settings.swift
//  AIrc
//
//  Created by Tim Harris on 7/11/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

class ClientStettings{
    var name:String
    var useSameName:Bool
    var nickName:String
    var useSameNickname:Bool
    var saveMediaLength:Int
    var useSaveMediaLength:Bool
    
    var reconnectToServersOnOpen:Bool
    var reconnectToChannelsOnOpen:Bool
    
    init(){
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
}