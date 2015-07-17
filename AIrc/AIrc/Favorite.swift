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
    
}