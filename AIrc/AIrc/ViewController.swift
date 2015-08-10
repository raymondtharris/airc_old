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

let AddingServerNotification:String = "AddingServerNotification"
let AddingChannelNotification:String = "AddingChannelNotification"
let UpdatingClientSettingsNotification:String = "UpdatingClientSettingsNotificatin"

class AIServerTableViewController: UITableViewController {
    var userClient:AIClient = AIClient()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        userClient.loadUser()
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
        
        return cell
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
            vcon.SettingsNameTextField.text = userClient.name
            vcon.SettingsNicknameTextField.text = userClient.nickName
            
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
        let url2 = NSURL(string: "http://chat.freenode.net:6667")!
        let task = NSURLSession.sharedSession().dataTaskWithURL(url2){ (data, response, error) in
            dispatch_async(dispatch_get_main_queue(), {
                self.getData(data!)
                print(response?.description)
                let tView = self.view as! UITableView
                tView.reloadData()
            })
        }
        task.resume()
        
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
        let tableView = self.view as! UITableView
        tableView.reloadData()
    }
    func updatingClientSettings(notification:NSNotification){
        let dataDictionary:Dictionary = notification.userInfo!
        print(dataDictionary)
        
        self.userClient.settings = dataDictionary["data"]!.clientData.settings as ClientStettings
        
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

class AIClientSettingsViewController: UIViewController {
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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
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
            self.clientData.settings.saveMediaLength = temp!
        }
        if self.clientData.settings.reconnectToServersOnOpen != self.SettingsReconnectServerSwitch.on {
            self.clientData.settings.reconnectToServersOnOpen = self.SettingsReconnectServerSwitch.on
        }
        if self.clientData.settings.reconnectToChannelsOnOpen != self.SettingsReconnectChannelSwitch.on {
            self.clientData.settings.reconnectToChannelsOnOpen = self.SettingsReconnectChannelSwitch.on
        }
        
        let dataDictionay:Dictionary = ["data": self.clientData]
        
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
        var newServer = AIServer(name: self.serverAddressTextField.text!, address: self.serverAddressTextField.text!, user: AIUser(), useSecureConnection: self.serverSecurePortSwitch.on)
        if self.serverSameCredentialsSwitch.on{
            // Get Client name and nickname
        } else{
            newServer.user.name = self.userNameTextField.text!
            newServer.user.nickname =  self.userNicknameTextField.text!
        }
        print(newServer)
        // TestConnection
        
        newServer.connect()
        
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