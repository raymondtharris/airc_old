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

class AIMedia: NSObject, NSCoding{
    var name:String //name of the media
    var typeOfMedia:mediaType // type of media
    var filesize:Int // filesize of the media object
    var dateAdded: NSDate //Date object was added in chat
    override var description:String{ // description variable
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
    func encodeWithCoder(aCoder: NSCoder) {
        
    }
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.typeOfMedia = aDecoder.decodeObjectForKey("typeOfMedia") as! mediaType
        self.filesize = aDecoder.decodeObjectForKey("filesize") as! Int
        self.dateAdded = aDecoder.decodeObjectForKey("dateAdded") as! NSDate
    }
}