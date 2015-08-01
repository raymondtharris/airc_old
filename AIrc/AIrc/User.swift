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
    init(){
        name = "User1"
        nickname = "NickUser1"
    }
    init(name:String, nickname:String){
        self.name = name
        self.nickname = nickname
    }
    init(name:String){
        self.name = name
        self.nickname = name
    }
    mutating func setName(name: String){
        self.name = name
    }
    mutating func setNickname(nickname: String){
        self.nickname = nickname
    }
}