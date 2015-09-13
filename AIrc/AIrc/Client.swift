//
//  Client.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import Foundation

let clientDataDirectory = NSSearchPathForDirectoriesInDomains( NSSearchPathDirectory.DocumentDirectory , NSSearchPathDomainMask.UserDomainMask, true)[0] as String
let clientDataFilename = "/clientdata.plist"
let pathToFile = clientDataDirectory.stringByAppendingString(clientDataFilename)

class AIClient: NSObject, NSCoding {
    
    var settings: ClientStettings // client settings variable
    //var connectedServers:[AIServer] // Array of conencted servers
    var favorites:[Favorite]
    var saveDataPath: AIClientSavePath
    override var description: String{ // description string
        return "\(settings.name) \(settings.nickName)."
    }
    override init() {
        
        //self.connectedServers = [AIServer]()
        self.settings = ClientStettings()
        self.favorites = [Favorite]()
        self.saveDataPath = AIClientSavePath()
    }
    init(name:String, nickName:String) {
       // self.connectedServers = [AIServer]()
        self.settings = ClientStettings()
        self.favorites = [Favorite]()
        self.saveDataPath = AIClientSavePath()
    }
    init(name:String, nickName:String, connectedServers: [AIServer]){
        //self.connectedServers = connectedServers
        self.settings = ClientStettings()
        self.favorites = [Favorite]()
        self.saveDataPath = AIClientSavePath()
    }
    func addServer(server:AIServer){
        //self.connectedServers.append(server)
    }
    func removeServer(server:AIServer){
        //removes a server
        var index:Int = 0
        print(index)
       // for var i = 0; i < self.connectedServers.count; i++ {
            //if connectedServers[i].name == server.name {
            //    index = i
          //  }
        //}
        //var firstHalf = self.connectedServers[0:i-1]
        
    }
    
    func connectedToServer(server: AIServer) -> Bool{
        let url = NSURL(string: server.address + ":" + server.port.description)!
        let request = NSURLRequest(URL: url)
        let task = NSURLSession.sharedSession().dataTaskWithRequest(request) {
            (data: NSData?, response: NSURLResponse?, error: NSError?) in
            //display and store the data from connecting to the IRC server
        }
        task.resume()
        //addServer(server)
        return false
    }
    func clientExists() -> Bool{
        let fileManager = NSFileManager.defaultManager()
        if !fileManager.fileExistsAtPath(pathToFile) {
            return false
        }
        return true
    }
    func createClientDataFile(){
        
    }
    func encodeWithCoder(aCoder: NSCoder) {
        aCoder.encodeObject(self.settings, forKey: "settings")
        //aCoder.encodeObject(self.connectedServers, forKey: "connectedServers")
        aCoder.encodeObject(self.favorites, forKey: "favorites")
    }
    required init?(coder aDecoder: NSCoder) {
        //setup savedatapath
        self.saveDataPath = AIClientSavePath()
        //Check for the file
        // if it exists load file
        self.settings = aDecoder.decodeObjectForKey("settings") as! ClientStettings
        //self.connectedServers = aDecoder.decodeObjectForKey("connectedServers") as! [AIServer]
        self.favorites = aDecoder.decodeObjectForKey("favorites") as! [Favorite]
        
        //else
        //self.connectedServers = [AIServer]()
        self.settings = ClientStettings()
        self.favorites = [Favorite]()
    }
    
    func saveData(){
        
        if !clientExists(){
            // make client
            createClientDataFile()
        }
        
        // save data saves AICLient data to a file
        var dataToWrite = NSMutableData()
        var archiver = NSKeyedArchiver(forWritingWithMutableData: dataToWrite)
        archiver.encodeObject(self)
        archiver.finishEncoding()
        dataToWrite.writeToFile(self.saveDataPath.dataPath, atomically: true)
        
    }
    
}

class AIClientSavePath: NSObject {
    var dataPath:String
    override var description:String{
        return "datapath: \(self.dataPath)"
    }
    override init() {
        self.dataPath = "clientdata.plist"
    }
    init(path:String){
        self.dataPath = path
    }
    
}



class userInfoObject<T> {
    var data: T
    init(data: T){
        self.data = data
    }
    var description: String{
        return "\(data)"
    }
}