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
    init(){
        self.name = "Test"
        self.useSameName = true
        self.nickName = self.name
        self.useSameNickname = true
    }
}