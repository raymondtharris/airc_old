//
//  User.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation


class AIUser:NSObject, NSCoding {
    var name:String //User name
    var nickname:String // Nickname for user
    override var description: String{ //description for user
        return "\(name) \(nickname)"
    }
    override init(){
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
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.nickname, forKey: "nickname")
    }
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.nickname = aDecoder.decodeObjectForKey("nickname") as! String
    }
}