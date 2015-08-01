//
//  Favorite.swift
//  AIrc
//
//  Created by Tim Harris on 7/16/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

struct Favorite {
    var post:AIPost
    var dateFavorited:NSDate
    var desciption:String{
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
}