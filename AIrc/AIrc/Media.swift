//
//  Media.swift
//  AIrc
//
//  Created by Tim Harris on 7/7/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

enum mediaType : CustomStringConvertible{
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
    var name:String
    var typeOfMedia:mediaType
    var description:String{
        return "\(name) \(typeOfMedia)"
    }
}