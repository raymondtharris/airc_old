//
//  ViewController.swift
//  AIrc
//
//  Created by Tim Harris on 7/4/15.
//  Copyright © 2015 Tim Harris. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

protocol AIClientData{
    func loadDefaults()
}
protocol TableViewBehaviors{
    func slideLeft(swipe: UIGestureRecognizer)
    func slideRight(swipe: UIGestureRecognizer)
}



let AddingServerNotification:String = "AddingServerNotification"
let AddingChannelNotification:String = "AddingChannelNotification"
let UpdatingClientSettingsNotification:String = "UpdatingClientSettingsNotificatin"

class AIServerTableViewController: UITableViewController,  NSStreamDelegate, AIClientData {
    var userClient:AIClient = AIClient()
    var outputStream = NSOutputStream()
    var inputStream = NSInputStream()
    var userDefaults = NSUserDefaults.standardUserDefaults()
    var deleteIndexPath: NSIndexPath? = nil
    
    func loadDefaults() {
        if userDefaults.objectForKey("name") != nil {
            userClient.settings.name =  userDefaults.objectForKey("name") as! String
        }
        if userDefaults.objectForKey("nickName") != nil {
            userClient.settings.nickName =  userDefaults.objectForKey("nickName") as! String
        }
        //userDefaults.removeObjectForKey("connectedServers")
        if userDefaults.objectForKey("connectedServers") != nil {
            let servers = userDefaults.objectForKey("connectedServers") as! NSArray
            for server in servers {
                //print(server as! AIServer)
                self.userClient.connectedServers.append(NSKeyedUnarchiver.unarchiveObjectWithData(server as! NSData) as! AIServer)
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDefaults()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addingNewServer:", name: AddingServerNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "updatingClientSettings:", name: UpdatingClientSettingsNotification, object: nil)
        
        //tempConnection()
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.userClient.connectedServers.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("serverCell", forIndexPath: indexPath) as! AIServerTableCellView
        cell.nameLabel.text = self.userClient.connectedServers[indexPath.row].address
        let swipe:UISwipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: Selector("swipeToDelete:"))
        swipe.direction = UISwipeGestureRecognizerDirection.Left
        cell.editing = true
        //cell.ed = UITableViewCellEditingStyle.Delete
        //cell.addGestureRecognizer(swipe)
        return cell
    }
    
    
  /*
    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        return true
    }
    */
    override func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
            let cell = tableView.cellForRowAtIndexPath(indexPath) as! AIServerTableCellView
            print(cell.nameLabel.text! + " " + indexPath.row.description)
            self.deleteIndexPath = indexPath
            let serverToDelete = self.userClient.connectedServers[indexPath.row]
            deleteServer(serverToDelete)
        
        
        
    }
    func deleteServer(server:AIServer){
        let alert = UIAlertController(title: "Delete Server", message: "Are you sure you want to remove \(server.name)?", preferredStyle: .ActionSheet)
        let DeleteAction = UIAlertAction(title: "Delete", style: .Destructive, handler: executeServerDelete)
        let CancelAction = UIAlertAction(title: "Cancel", style: .Cancel, handler: cancelServerDelete)
        
        alert.addAction(DeleteAction)
        alert.addAction(CancelAction)
        
        self.presentViewController(alert, animated: true, completion: nil)
    }
    
    func executeServerDelete(alertAction: UIAlertAction!) {
        print("deleting")
        let tableView = self.view as! UITableView
        
        tableView.beginUpdates()
        self.userClient.connectedServers.removeAtIndex(self.deleteIndexPath!.row)
        
        print(self.userClient.connectedServers)
        let tempData:NSMutableArray = NSMutableArray()
        
        for server in self.userClient.connectedServers {
            //var archiver = NSKeyedArchiver()
            tempData.addObject(NSKeyedArchiver.archivedDataWithRootObject(server) )
        }
        
        self.userDefaults.setObject(tempData, forKey: "connectedServers")
        
        
        
        print(self.deleteIndexPath!)
        tableView.deleteRowsAtIndexPaths([self.deleteIndexPath!], withRowAnimation: UITableViewRowAnimation.Left)
        self.deleteIndexPath = nil
        tableView.endUpdates()
        
    }
    func cancelServerDelete(alertAction: UIAlertAction!) {
        print("cancel")
        self.deleteIndexPath = nil
    }
    
    func saveDefaults( items: [String]) {
        for item in items {
            switch item{
            case "connectedServers":
                
                break
            case "name":
                break
            case "nickName":
                break
            default:  break
            }
        }
    }
    
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showChannelViewController" {
            let tView = self.view as! UITableView
            let indexPath:NSIndexPath = tView.indexPathForSelectedRow!
            let vcon = segue.destinationViewController as! AIChannelTableViewController
            let serverToUse = userClient.connectedServers[indexPath.row]
            vcon.title =  serverToUse.name
            vcon.connectedChannels = serverToUse.connectedChannels
            
        }
        if segue.identifier == "showClientViewController" {
            
            let vcon = segue.destinationViewController as! AIClientSettingsViewController
            vcon.clientData = userClient
            vcon.SettingsNameTextField.text = userClient.settings.name
            vcon.SettingsNicknameTextField.text = userClient.settings.nickName
            
            vcon.SettingsSameNameSwitch.on = userClient.settings.useSameName.boolValue
            vcon.SettingsSameNicknameSwitch.on = userClient.settings.useSameNickname.boolValue
            
            vcon.SettingsReconnectChannelSwitch.on = userClient.settings.reconnectToChannelsOnOpen.boolValue
            vcon.SettingsReconnectServerSwitch.on = userClient.settings.reconnectToServersOnOpen.boolValue
            
            vcon.SettingsSaveMediaSwitch.on = userClient.settings.useSaveMediaLength.boolValue
            vcon.SettingsSaveDurationTextField.text = userClient.settings.saveMediaLength.description
        }
        
    }
    
    func tempConnection(){
       // let url = NSURL(string: "http://localhost:4000/blog_info")!
        //let url2 = NSURL(string: "http://chat.freenode.net:6667")!
        var readStream: Unmanaged<CFReadStreamRef>?
        var writeStream: Unmanaged<CFWriteStreamRef>?
        CFStreamCreatePairWithSocketToHost(kCFAllocatorDefault, "http://chat.freenode.net", 6667, &readStream, &writeStream)
        self.inputStream = readStream!.takeRetainedValue()
        self.outputStream = writeStream!.takeRetainedValue()
        
        self.inputStream.delegate = self
        self.outputStream.delegate = self
        
        self.inputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        self.outputStream.scheduleInRunLoop(NSRunLoop.currentRunLoop(), forMode: NSDefaultRunLoopMode)
        
        self.inputStream.open()
        self.outputStream.open()
        
       /*
        let task = NSURLSession.sharedSession().dataTaskWithURL(url2){ (data, response, error) in
            //self.outputStream = NSOutputStream(
            self.inputStream  = NSInputStream(URL: url2)!
            
            //self.inputStream.open()
            //print(self.inputStream.description)
            dispatch_async(dispatch_get_main_queue(), {
                
                self.getData(data!)
                //print(response?.description)
                let tView = self.view as! UITableView
                tView.reloadData()
            })
        }
        task.resume()
*/
        
    }
    
    func stream(aStream: NSStream, handleEvent eventCode: NSStreamEvent) {
        switch (eventCode){
        case NSStreamEvent.ErrorOccurred:
            NSLog("ErrorOccurred")
            break
        case NSStreamEvent.EndEncountered:
            NSLog("EndEncountered")
            break
        case NSStreamEvent.None:
            NSLog("None")
            break
        case NSStreamEvent.HasBytesAvailable:
            NSLog("HasBytesAvaible")
            var buffer = [UInt8](count: 4096, repeatedValue: 0)
            if ( aStream == self.inputStream){
                
                while (self.inputStream.hasBytesAvailable){
                    let len = self.inputStream.read(&buffer, maxLength: buffer.count)
                    if(len > 0){
                        let output = NSString(bytes: &buffer, length: buffer.count, encoding: NSUTF8StringEncoding)
                        if (output != ""){
                            NSLog("server said: %@", output!)
                        }
                    }
                }
            }
            break
        //case NSStreamEvent.contains():
          //  NSLog("allZeros")
            //break
        case NSStreamEvent.OpenCompleted:
            NSLog("OpenCompleted")
            break
        case NSStreamEvent.HasSpaceAvailable:
            NSLog("HasSpaceAvailable")
            break
        default:
            break
        }
        
    }
    func getData(data:NSData){
        //var error: NSError?
        //var jsonObj: AnyObject?
        let str = NSString(data: data, encoding: NSUTF8StringEncoding)!
        print(str)
        //print(data)
        /*
        do{
            
            try jsonObj = NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! NSDictionary
            
            print(jsonObj)
            //self.testVals.append((jsonObj?.objectForKey("Name"))! as! String)
            
            
        }catch{
            print(error)
        }
        */
    }
    
    func addingNewServer(notification: NSNotification){
        let dataDictionary:Dictionary = notification.userInfo!
        print(dataDictionary)
        let serverToAdd:AIServer = AIServer(name: dataDictionary["address"] as! String, address: dataDictionary["address"] as! String, user: AIUser(name: dataDictionary["user"] as! String, nickname: dataDictionary["nickname"] as! String), useSecureConnection: dataDictionary["secure"] as! Bool)
        self.userClient.connectedServers.append(serverToAdd)
        print(self.userClient.connectedServers)
        var tempData:NSMutableArray = NSMutableArray()
        
        for server in self.userClient.connectedServers {
            //var archiver = NSKeyedArchiver()
            tempData.addObject(NSKeyedArchiver.archivedDataWithRootObject(server) )
        }
        
        self.userDefaults.setObject(tempData, forKey: "connectedServers")
        
        let tableView = self.view as! UITableView
        tableView.reloadData()
    }
    func updatingClientSettings(notification:NSNotification){
        let dataDictionary:Dictionary = notification.userInfo!
        print(dataDictionary)
        
        self.userClient.settings = dataDictionary["data"]!.settings as ClientStettings
        
    }
}

class AIChannelTableViewController: UITableViewController {
    var testChannels = [("what", 3), ("who", 16), ("when", 10), ("testing", 4)]
    var connectedChannels = [AIChannel]()
    var server = AIServer()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "addingNewChannel:", name: AddingChannelNotification, object: nil)

    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return connectedChannels.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("channelCell", forIndexPath: indexPath) as! AIChannelTableCellView
        cell.nameLabel.text = connectedChannels[indexPath.row].name
        cell.unreadCountLabel.text = connectedChannels[indexPath.row].unreadCount.description
        return cell
    }
    func addingNewChannel(notification:NSNotification){
        let dataDictionary:Dictionary = notification.userInfo!
        print(dataDictionary)
        let channelToAdd = AIChannel(name: dataDictionary["name"] as! String, unreadCount: 0, channelState: stateType.Connecting, autoReconnect: dataDictionary["auto"] as! Bool)
        self.connectedChannels.append(channelToAdd)
        self.server.connectedChannels = self.connectedChannels
        let tableView = self.view as! UITableView
        tableView.reloadData()
    }
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showChannelSegue" {
            let tView = self.view as! UITableView
            let indexPath:NSIndexPath = tView.indexPathForSelectedRow!
            let vcon = segue.destinationViewController as! AIChannelTableViewController
            let channelToUse = connectedChannels[indexPath.row]
            vcon.title =  channelToUse.name
            
        }
    }
    
}

class AIChannelChatViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // check user settings to see if use same name is true
    }
    

    
}

class AIClientSettingsViewController: UIViewController, AIClientData {
    @IBOutlet weak var SettingsNameLabel: UILabel!
    @IBOutlet weak var SettingsNameTextField: UITextField!
    @IBOutlet weak var SettingsNicknameLabel: UILabel!
    @IBOutlet weak var SettingsNicknameTextField: UITextField!
    
    @IBOutlet weak var SettingSameNameLabel: UILabel!
    @IBOutlet weak var SettingsSameNameSwitch: UISwitch!
    @IBOutlet weak var SettingsSameNicknameLabel: UILabel!
    @IBOutlet weak var SettingsSameNicknameSwitch: UISwitch!
    
    @IBOutlet weak var SettingsSaveMediaLabel: UILabel!
    @IBOutlet weak var SettingsSaveMediaSwitch: UISwitch!
    @IBOutlet weak var SettingsSaveDurationLabel: UILabel!
    @IBOutlet weak var SettingsSaveDurationTextField: UITextField!
    
    @IBOutlet weak var SettingsReconnectServerLabel: UILabel!
    @IBOutlet weak var SettingsReconnectServerSwitch: UISwitch!
    @IBOutlet weak var SettingsReconnectChannelLabel: UILabel!
    @IBOutlet weak var SettingsReconnectChannelSwitch: UISwitch!
    
    @IBOutlet weak var SettingsDoneButton: UIBarButtonItem!
    
    var clientData = AIClient()
    var userDefaults = NSUserDefaults.standardUserDefaults()
    
    func loadDefaults() {
        if userDefaults.objectForKey("name") != nil {
            clientData.settings.name =  userDefaults.objectForKey("name") as! String
            SettingsNameTextField.text = clientData.settings.name
        }
        if userDefaults.objectForKey("nickName") != nil {
            clientData.settings.nickName =  userDefaults.objectForKey("nickName") as! String
            SettingsNicknameTextField.text = clientData.settings.nickName
        }
        if userDefaults.objectForKey("useSameName") != nil {
            clientData.settings.useSameName =  userDefaults.objectForKey("useSameName") as! Bool
            SettingsSameNameSwitch.on = clientData.settings.useSameName
        }
        if userDefaults.objectForKey("useSameNickname") != nil {
            clientData.settings.useSameNickname =  userDefaults.objectForKey("useSameNickname") as! Bool
            SettingsSameNicknameSwitch.on = clientData.settings.useSameNickname
        }
        if userDefaults.objectForKey("useSaveMediaLength") != nil {
            clientData.settings.useSaveMediaLength =  userDefaults.objectForKey("useSaveMediaLength") as! Bool
            SettingsSaveMediaSwitch.on = clientData.settings.useSaveMediaLength
        }
        if userDefaults.objectForKey("saveMediaLength") != nil {
            clientData.settings.saveMediaLength =  userDefaults.objectForKey("saveMediaLength") as! Int
            SettingsSaveDurationTextField.text = clientData.settings.saveMediaLength.description
        }
        if userDefaults.objectForKey("reconnectToServersOnOpen") != nil {
            clientData.settings.reconnectToServersOnOpen =  userDefaults.objectForKey("reconnectToServersOnOpen") as! Bool
            SettingsReconnectServerSwitch.on = clientData.settings.reconnectToServersOnOpen
        }
        if userDefaults.objectForKey("reconnectToChannelsOnOpen") != nil {
            clientData.settings.reconnectToChannelsOnOpen =  userDefaults.objectForKey("reconnectToChannelsOnOpen") as! Bool
            SettingsReconnectChannelSwitch.on = clientData.settings.reconnectToChannelsOnOpen
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadDefaults()
    }
    @IBAction func UpdateSettings(sender: AnyObject) {
        if self.clientData.settings.useSameNickname != self.SettingsSameNicknameSwitch.on {
            self.clientData.settings.useSameNickname = self.SettingsSameNicknameSwitch.on
        }
        if self.clientData.settings.useSameName != self.SettingsSameNameSwitch.on {
            self.clientData.settings.useSameName = self.SettingsSameNameSwitch.on
        }
        if self.clientData.settings.name != self.SettingsNameTextField.text {
            self.clientData.settings.name = self.SettingsNameTextField.text!
        }
        if self.clientData.settings.nickName != self.SettingsNicknameTextField.text {
            self.clientData.settings.nickName = self.SettingsNicknameTextField.text!
        }
        if self.clientData.settings.useSaveMediaLength != self.SettingsSaveMediaSwitch.on {
            self.clientData.settings.useSaveMediaLength = self.SettingsSaveMediaSwitch.on
        }
        let temp = Int(self.SettingsSaveDurationTextField.text!)
        if self.clientData.settings.saveMediaLength != temp {
            self.clientData.settings.saveMediaLength = 4
        }
        if self.clientData.settings.reconnectToServersOnOpen != self.SettingsReconnectServerSwitch.on {
            self.clientData.settings.reconnectToServersOnOpen = self.SettingsReconnectServerSwitch.on
        }
        if self.clientData.settings.reconnectToChannelsOnOpen != self.SettingsReconnectChannelSwitch.on {
            self.clientData.settings.reconnectToChannelsOnOpen = self.SettingsReconnectChannelSwitch.on
        }
        
        let dataDictionay:Dictionary = ["data": self.clientData]
        
        userDefaults.setValue(clientData.settings.name, forKey: "name")
        userDefaults.setValue(clientData.settings.nickName, forKey: "nickName")
        userDefaults.setValue(clientData.settings.useSameName, forKey: "useSameName")
        userDefaults.setValue(clientData.settings.useSameNickname, forKey: "useSameNickname")
        userDefaults.setValue(clientData.settings.useSaveMediaLength, forKey: "useSaveMediaLength")
        userDefaults.setValue(clientData.settings.saveMediaLength, forKey: "saveMediaLength")
        userDefaults.setValue(clientData.settings.reconnectToServersOnOpen, forKey: "reconnectToServersOnOpen")
        userDefaults.setValue(clientData.settings.reconnectToChannelsOnOpen, forKey: "reconnectToChannelsOnOpen")
        
        NSNotificationCenter.defaultCenter().postNotificationName(UpdatingClientSettingsNotification, object: self, userInfo: dataDictionay as [NSObject: AnyObject])
        
        
        self.navigationController?.popViewControllerAnimated(true)
    }
}

class AIServerConfigurationViewController: UIViewController {
    
    @IBOutlet weak var serverAddressLabel: UILabel!
    @IBOutlet weak var serverAddressTextField: UITextField!
    
    @IBOutlet weak var serverSecurePortSwitch: UISwitch!
    
    @IBOutlet weak var serverSameCredentialsSwitch: UISwitch!
    
    
    @IBOutlet weak var userNameLabel: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var userNicknameLabel: UILabel!
    @IBOutlet weak var userNicknameTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        toggleSameCredentials(self)
    }
    @IBAction func addServer(sender: AnyObject) {
        // Making a server work
        let newServer = AIServer(name: self.serverAddressTextField.text!, address: self.serverAddressTextField.text!, user: AIUser(), useSecureConnection: self.serverSecurePortSwitch.on)
        if self.serverSameCredentialsSwitch.on{
            // Get Client name and nickname
        } else{
            newServer.user.name = self.userNameTextField.text!
            newServer.user.nickname =  self.userNicknameTextField.text!
        }
        print(newServer)
        // TestConnection
        newServer.connectTest()
        //newServer.connect("first")
        
        // if connection works send it to be added to the array
        let dataDictionary:NSDictionary = ["address": newServer.address, "user": newServer.user.name, "nickname": newServer.user.nickname, "secure": newServer.useSecureConnection]
        //let temp = userInfoObject(data: newServer)
        
        
        
        NSNotificationCenter.defaultCenter().postNotificationName(AddingServerNotification, object: self, userInfo: dataDictionary as [NSObject : AnyObject])
        //postNotificationName("AddingServerNotification", object: self, userInfo: dataDictionary) //Need to send Object data with notificaiton post
        
        //Return to other viewcontroller
        self.navigationController?.popViewControllerAnimated(true)
        
    }
    @IBAction func toggleSameCredentials(sender: AnyObject) {
        print(sender)
        if self.serverSameCredentialsSwitch.on{
            //hide the labels and textfields
            self.userNameLabel.hidden = true
            self.userNameTextField.hidden = true
            self.userNicknameLabel.hidden = true
            self.userNicknameTextField.hidden = true
        } else{
            //unhide the labels and textfields
            self.userNameLabel.hidden = false
            self.userNameTextField.hidden = false
            self.userNicknameLabel.hidden = false
            self.userNicknameTextField.hidden = false
        }
    }
}

class AIChannelConfigurationViewController: UIViewController {
    @IBOutlet weak var channelNameLabel: UILabel!
    @IBOutlet weak var channelNameTextField: UITextField!
    
    @IBOutlet weak var channelAutoConnectLabel: UILabel!
    @IBOutlet weak var channelAutoConnectSwitch: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func addChannel(sender: AnyObject) {
        let newChannel = AIChannel(name: self.channelNameTextField.text!, unreadCount: 0, channelState: stateType.Unconnected, autoReconnect: self.channelAutoConnectSwitch.on)
        print(newChannel)
        let dataDictionary = ["name": newChannel.name, "auto": newChannel.autoReconnect]
        NSNotificationCenter.defaultCenter().postNotificationName(AddingChannelNotification, object: self, userInfo: dataDictionary as [NSObject: AnyObject])
        
        // Redirect to channelTableView
        self.navigationController?.popViewControllerAnimated(true)
        
    }
}

class AIChannelDetailViewController: UIViewController {
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}