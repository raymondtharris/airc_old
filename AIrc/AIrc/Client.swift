//
//  Client.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

class AIClient: NSObject {
    var name:String //Name for client
    var nickName: String //Nickname for client
    var settings: ClientStettings // client settings variable
    var connectedServers:[AIServer] // Array of conencted servers
    
    override var description: String{ // description string
        return "\(name) \(nickName) \nConnected to \(connectedServers.count) servers."
    }
    override init() {
        self.name = "Test"
        self.nickName = "Testing"
        self.connectedServers = [AIServer]()
        self.settings = ClientStettings()
    }
    init(name:String, nickName:String) {
        self.name = name
        self.nickName = nickName
        self.connectedServers = [AIServer]()
        self.settings = ClientStettings()
    }
    init(name:String, nickName:String, connectedServers: [AIServer]){
        self.name = name
        self.nickName = nickName
        self.connectedServers = connectedServers
        self.settings = ClientStettings()
    }
    func addServer(server:AIServer){
        self.connectedServers.append(server)
    }
    func removeServer(server:AIServer){
        //removes a server
        
    }
    
    func connectedToServer(server: AIServer) -> Bool{
        let url = NSURL(string: server.address + ":" + server.port.description)!
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            //display and store the data from connecting to the IRC server
        }
        task?.resume()
        addServer(server)
        return false
    }
}