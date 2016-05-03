//
//  ChatViewController.swift
//  Chat Parse Demo
//
//  Created by Corwin Crownover on 3/18/16.
//  Copyright © 2016 Corwin Crownover. All rights reserved.
//

import UIKit
import Parse 

class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    // OUTLETS
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var textField: UITextField!
    
    var messages: [PFObject]! = []
    
    
    // VIEW DID LOAD

    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        // if autoalayout is turned on and all top bottom left right constraints are active:
        tableView.rowHeight = UITableViewAutomaticDimension
        
        // choose some acceptable dimension (doesn't have to be exact). this is just for the scroll indicators:
        tableView.estimatedRowHeight = 50
        
        // Have it run every 3 seconds
        let timer = NSTimer.scheduledTimerWithTimeInterval(3, target: self, selector: "onTimer", userInfo: nil, repeats: true)
        
        timer.fire()
    }
    
    func onTimer() {
        let query = PFQuery(className: "Message")
        query.whereKey("user", equalTo: PFUser.currentUser()!)
        query.findObjectsInBackgroundWithBlock { (existingMessages:[PFObject]?, error: NSError?) -> Void in
            self.messages = existingMessages
            self.tableView.reloadData()
        }
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    


    
    // FUNCTIONS
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("MessageCell") as! MessageCell
        
        let message = messages[indexPath.row]
        cell.messageLabel.text = message["text"] as? String
        
        return cell
    }
    
    @IBAction func onSend(sender: AnyObject) {
        let message = PFObject(className: "Message")
        
        message["text"] = textField.text
        message["random"] = "awesome"
        message["my_picture_url"] = "http://"
        // tag messages with me:
        message["user"] = PFUser.currentUser()
        
        message.saveInBackgroundWithBlock { (success: Bool, error: NSError?) -> Void in
            print("saved message")
        }
        
        // immediately add message to chat view controller view (don't wait for query)
        messages.append(message)
    }
    
    
    
    
    
    

}
