//
//  Post.swift
//  AIrc
//
//  Created by Tim Harris on 7/15/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

class AIPost:NSObject, NSCoding {
    var body:String
    var datePosted:NSDate
    var user:AIUser
    override var description: String{
        return "\(user) \(datePosted): \(body)"
    }
    
    init(user:AIUser, datePosted:NSDate, body:String){
        self.user = user
        self.datePosted = datePosted
        self.body = body
    }
    init(user:AIUser, body:String){
        self.user = user
        self.body = body
        self.datePosted = NSDate()
    }
    required init?(coder aDecoder: NSCoder) {
        self.body = aDecoder.decodeObjectForKey("body") as! String
        self.datePosted = aDecoder.decodeObjectForKey("datePosted") as! NSDate
        self.user = aDecoder.decodeObjectForKey("user") as! AIUser
    }
    func encodeWithCoder(aCoder: NSCoder) {
        
    }
    
}