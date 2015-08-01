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
    init(name:String, typeOfMedia: mediaType, filesize: Int){
        self.name = name
        self.typeOfMedia = typeOfMedia
        self.filesize = filesize
        self.dateAdded = NSDate()
    }
    init(name:String, typeOfMedia: mediaType, filesize: Int, dateAdded: NSDate){
        self.name = name
        self.typeOfMedia = typeOfMedia
        self.filesize = filesize
        self.dateAdded = dateAdded
    }
    mutating func setName(name: String){
        self.name = name
    }
    mutating func setTypeOfMedia(typeOfMedia:mediaType){
        self.typeOfMedia = typeOfMedia
    }
    mutating func setFilesize(filesize:Int){
        self.filesize = filesize
    }
    mutating func setDateAdded(dateAdded: NSDate){
        self.dateAdded = dateAdded
    }
}