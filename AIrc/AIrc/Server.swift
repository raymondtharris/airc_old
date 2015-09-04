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
    func connectTest() -> Bool
    func connect(option:String)
    func disconnect()
    
}

func convertType(stringType:String) ->stateType{
    //Converts the string value of a stateType back in to a stateType. Used for initWithEncoder
    switch stringType{
    case "Connected": return stateType.Connected;
    case "Unconnected": return stateType.Unconnected;
    case "Disconnected": return stateType.Disconnected;
    case "Reconnecting": return stateType.Reconnecting;
    case "Connecting": return stateType.Connecting;
    default: return stateType.Disconnected;
    }
}



class AIServer : NSObject, NSCoding, Convenience {
    var name:String //Name of the server
    var port:Int //Port number used to connect to server
    var address:String //The address for the server
    var connectedChannels:[AIChannel] //List of channels on server that have been connected to
    var user:AIUser //User that is connecting to server
    var serverChannelList:[AIChannel] //List of channels on the server
    var useSecureConnection:Bool //Is connection using secure port
    var serverState: stateType //State of server for the user
    var session: NSURLSession = NSURLSession.sharedSession() //Session for Server
    
    var inputStream:NSInputStream = NSInputStream()
    var outputStream:NSOutputStream = NSOutputStream()
    
    
    
    override var description: String{
        //Description for AIServer
        return "\(name) \(port) \(address)"
    }
    override init(){
        name = "Temp"
        port = UNSECURE_PORT
        address = "http://chat.freenode.net"
        connectedChannels = [AIChannel]()
        user = AIUser()
        serverChannelList = [AIChannel]()
        useSecureConnection = false
        serverState = stateType.Unconnected
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
    }
    
    init(name: String, address: String, user: AIUser, useSecureConnection: Bool){
        self.name = name
        if useSecureConnection{
            self.port = SECURE_PORT
        }else{
            self.port = UNSECURE_PORT
        }
        self.address = address
        self.connectedChannels = [AIChannel]()
        self.user = user
        self.serverChannelList = [AIChannel]()
        self.useSecureConnection = useSecureConnection
        self.serverState = stateType.Unconnected
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.name, forKey: "name")
        aCoder.encodeObject(self.port, forKey: "port")
        aCoder.encodeObject(self.address, forKey: "address")
        aCoder.encodeObject(self.connectedChannels, forKey: "connectedChannels")
        aCoder.encodeObject(self.user, forKey: "user")
        aCoder.encodeObject(self.serverChannelList, forKey: "serverChannelList")
        aCoder.encodeObject(self.useSecureConnection, forKey: "useSecureConnection")
        aCoder.encodeObject(self.serverState.description, forKey: "serverState")
        
    }
    required init?(coder aDecoder: NSCoder) {
        self.name = aDecoder.decodeObjectForKey("name") as! String
        self.port = aDecoder.decodeObjectForKey("port") as! Int
        self.address = aDecoder.decodeObjectForKey("address") as! String
        self.connectedChannels = aDecoder.decodeObjectForKey("connectedChannels") as! [AIChannel]
        self.user = aDecoder.decodeObjectForKey("user") as! AIUser
        self.serverChannelList = aDecoder.decodeObjectForKey("serverChannelList") as! [AIChannel]
        self.useSecureConnection = aDecoder.decodeObjectForKey("useSecureConnection") as! Bool
        self.serverState = convertType( aDecoder.decodeObjectForKey("serverState") as! String)
    }
    
    
    func addChannel(channel:AIChannel){ //Adds Channel to connectedChannels array
        connectedChannels.append(channel)
    }
    func removeChannel(channel:AIChannel){
        
    }
    func removeChannelByName(channelName:String){
        
    }
    func updateUser(userData:AIUser){ //Updates user data
        user = userData
    }
    
    func joinChannel(channel:AIChannel){
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
        task.resume()
        addChannel(channel)
    }
    
    func fetchChannelList(){
        
    }
    
    func postMessageToChannel(Channel: AIChannel, Post: AIPost) -> Bool{
        print(Post.body)
        let postString: String = "\(self.user.nickname) : \(Post.body)"
        print(postString)
        
        return false
    }
    
    
    func connectTest() -> Bool {
        var readStream:NSInputStream?
        var writeStream:NSOutputStream?
        autoreleasepool({ () in
            NSStream.getStreamsToHostWithName("http://chat.freenode.net", port: 6667, inputStream: &readStream, outputStream: &writeStream)
            
            let inputStream = readStream!
            let outputStream = writeStream!
            inputStream.open()
            outputStream.open()
            var readByte: UInt8 = 0
            if inputStream.hasBytesAvailable {
                print("whaohf")
                let temp = inputStream.read(&readByte, maxLength: 1)
                
            }
            print(inputStream)
            //outputStream.write(<#T##buffer: UnsafePointer<UInt8>##UnsafePointer<UInt8>#>, maxLength: <#T##Int#>)
        })
        
        
        return false
    }
    
    func connect(option:String) {
        var url:NSURL
        if self.port == SECURE_PORT {
            url = NSURL(string: "https://" + self.address + ":" + self.port.description)!
        } else {
            url = NSURL(string: "http://" + self.address + ":" + self.port.description)!
        }
        self.session = NSURLSession.sharedSession()
        let connectTask = self.session.dataTaskWithURL(url, completionHandler: { (data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                self.serverState = stateType.Connecting
                let str = NSString(data: data!, encoding: NSUTF8StringEncoding)!
                print(str)
                print(response?.description)
                
                self.serverState = stateType.Connected
            })
        
        })
        connectTask.resume()
        let sendReq = NSMutableURLRequest(URL: url)
        let sendStr = "NICK \(self.user.nickname)\nUSER \(self.user.name) 1 1 1:Hi this is a test"
        sendReq.HTTPMethod = "PUT"
        sendReq.HTTPBody = sendStr.dataUsingEncoding(NSUTF8StringEncoding)!
        //sendReq.setValue("NICK \(self.user.nickname)\nUSER \(self.user.name) 1 1 1:Hi this is a test", forKey: "HTTPBody")

        let SendTask = self.session.dataTaskWithRequest(sendReq, completionHandler: {(data,response, err) in
            let str = NSString(data: data!, encoding: NSUTF8StringEncoding)!
            print(str)
            print(response?.description)
        })
        SendTask.resume()
        //self.session.configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
        
        
    }
    func disconnect() {
        if self.serverState != stateType.Unconnected  || self.serverState != stateType.Disconnected {
            self.session = NSURLSession.sharedSession()
            self.serverState = stateType.Disconnected
        }
    }
    
}
