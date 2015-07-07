//
//  Server.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

let UNSECURE_PORT = 6667
let SECURE_PORT = 6697

struct AIServer {
    var name:String
    var port:Int
    var address:String
    var connectedChannels:[AIChannel]
    var user:AIUser
    var serverChannelList:[AIChannel]
    var useSecureConnection:Bool
    var serverState: stateType
    
    var description: String{
        return "\(name) \(port) \(address)"
    }
    
    mutating func addChannel(channel:AIChannel){
        connectedChannels.append(channel)
    }
    mutating func updateUser(userData:AIUser){
        user = userData
    }
    
    mutating func connectToChannel(channel:AIChannel){
        if useSecureConnection{
            self.port = SECURE_PORT
        } else{
            self.port = UNSECURE_PORT
        }
        let url = NSURL(string: self.address + ":" + self.port.description + "/" + channel.name)!
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            //display and store the data from connecting to the IRC server
        }
        task?.resume()
        addChannel(channel)
    }
    
    mutating func fetchChannelList(){
        
    }
}
