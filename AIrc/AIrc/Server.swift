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


protocol Convenience{
    mutating func connect()
    mutating func disconnect()
}


struct AIServer : Convenience {
    var name:String //Name of the server
    var port:Int //Port number used to connect to server
    var address:String //The address for the server
    var connectedChannels:[AIChannel] //List of channels on server that have been connected to
    var user:AIUser //User that is connecting to server
    var serverChannelList:[AIChannel] //List of channels on the server
    var useSecureConnection:Bool //Is connection using secure port
    var serverState: stateType //State of server for the user
    var session: NSURLSession //Session for Server
    
    var description: String{
        //Description for AIServer
        return "\(name) \(port) \(address)"
    }
    init(){
        name = "Temp"
        port = SECURE_PORT
        address = "http://chat.freenode.net"
        connectedChannels = [AIChannel]()
        user = AIUser()
        serverChannelList = [AIChannel]()
        useSecureConnection = false
        serverState = stateType.Unconnected
        session = NSURLSession.sharedSession()
    }
    
    init(name: String, port: Int, address: String, user: AIUser, useSecureConnection: Bool){
        self.name = name
        self.port = port
        self.address = address
        self.connectedChannels = [AIChannel]()
        self.user = user
        self.serverChannelList = [AIChannel]()
        self.useSecureConnection = useSecureConnection
        self.serverState = stateType.Unconnected
        self.session = NSURLSession.sharedSession()
    }
    
    mutating func addChannel(channel:AIChannel){ //Adds Channel to connectedChannels array
        connectedChannels.append(channel)
    }
    mutating func removeChannel(channel:AIChannel){
        
    }
    mutating func removeChannelByName(channelName:String){
        
    }
    mutating func updateUser(userData:AIUser){ //Updates user data
        user = userData
    }
    
    mutating func joinChannel(channel:AIChannel){
        // Function to join a channel found one the server
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
    
    mutating func connect() {
        
    }
    mutating func disconnect() {
        
    }
}
