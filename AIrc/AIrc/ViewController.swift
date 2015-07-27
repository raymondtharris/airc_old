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

class AIServerTableViewController: UITableViewController {
    var testVals = ["what", "who", "when"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testVals.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("serverCell", forIndexPath: indexPath) as! AIServerTableCellView
        cell.nameLabel.text = testVals[indexPath.row]
        return cell
    }
}

class AIChannelTableViewController: UITableViewController {
    var testChannels = [("what", 3), ("who", 16), ("when", 10), ("testing", 4)]
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return testChannels.count
    }
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("channelCell", forIndexPath: indexPath) as! AIChannelTableCellView
        cell.nameLabel.text = testChannels[indexPath.row].0
        cell.unreadCountLabel.text = testChannels[indexPath.row].1.description
        return cell
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    @IBAction func UpdateSettings(sender: AnyObject) {
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
    }
    @IBAction func addServer(sender: AnyObject) {
    }
    @IBAction func toggleSameCredentials(sender: AnyObject) {
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
    }
}

class AIChannelDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}