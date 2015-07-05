//
//  Client.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

class AIClient: NSObject {
    var name:String
    var nickName: String
    var connectedServers:[AIServer]
    override init() {
        self.name = "Test"
        self.nickName = "Testing"
        self.connectedServers = [AIServer]()
    }
    init(name:String, nickName:String) {
        self.name = name
        self.nickName = nickName
        self.connectedServers = [AIServer]()
    }
    init(name:String, nickName:String, connectedServers: [AIServer]){
        self.name = name
        self.nickName = nickName
        self.connectedServers = connectedServers
    }
    func addServer(server:AIServer){
        self.connectedServers.append(server)
    }
    
    func connectedToServer(server: AIServer) -> Bool{
        let url = NSURL(string: server.address + ":" + server.port.description)!
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
        }
        task?.resume()
        addServer(server)
        return false
    }
}