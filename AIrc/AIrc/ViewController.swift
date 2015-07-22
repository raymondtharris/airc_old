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
    }
}

class AIServerConfigurationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class AIChannelConfigurationViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

class AIChannelDetailViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}