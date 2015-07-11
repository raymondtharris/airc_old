//
//  Media.swift
//  AIrc
//
//  Created by Tim Harris on 7/7/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

enum mediaType : CustomStringConvertible{ // Media Types
    case Link
    case Image
    case Audio
    case Video
    var description: String{
        switch self{
        case .Link: return "Link";
        case .Image: return "Image";
        case .Audio: return "Audio";
        case .Video: return "Video";
        }
    }
}

struct AIMedia{
    var name:String //name of the media
    var typeOfMedia:mediaType // type of media
    var filesize:Int // filesize of the media object
    var dateAdded: NSDate //Date object was added in chat
    var description:String{ // description variable
        return "\(name) \(typeOfMedia)"
    }
}