//
//  Favorite.swift
//  AIrc
//
//  Created by Tim Harris on 7/16/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

class Favorite: NSObject, NSCoding {
    var post:AIPost
    var dateFavorited:NSDate
    override var description:String{
        return "\(dateFavorited):  \(post.description)"
    }
    init(post:AIPost){
        self.post = post
        self.dateFavorited = NSDate()
    }
    init(post:AIPost, dateFavorited:NSDate){
        self.post = post
        self.dateFavorited = dateFavorited
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.post, forKey: "post")
        aCoder.encodeObject(self.dateFavorited, forKey: "dateFavorited")
    }
    required init?(coder aDecoder: NSCoder) {
        self.post = aDecoder.decodeObjectForKey("post") as! AIPost
        self.dateFavorited = aDecoder.decodeObjectForKey("dateFavorited") as! NSDate
    }
}