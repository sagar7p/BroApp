//
//  ViewController.swift
//  Bro
//
//  Created by Sagar Punhani on 3/3/16.
//  Copyright © 2016 Sagar Punhani. All rights reserved.
//

import UIKit
import Firebase

//Message class
class Message {
    var message: String
    var currentUser: Bool
    init(msg: String, user: Bool, messageLabel: UILabel) {
        message = msg
        currentUser = user
        label = messageLabel
    }
    var label: UILabel
}
class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    //reference to firebase
    //TODO
    var ref = Firebase(url: "https://my-bro-app.firebaseio.com")
    
    //class variables
    var messages = [Message]()
    
    var myMessage = false
    
    var newItems = false
    
    //buttons
    @IBOutlet weak var bro1: UIButton!
    
    @IBOutlet weak var bro2: UIButton!
    @IBOutlet weak var bro3: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
    
    //setup
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        bro1.clipsToBounds = true
        bro1.layer.cornerRadius = 5.0
        bro2.clipsToBounds = true
        bro2.layer.cornerRadius = 5.0
        bro3.clipsToBounds = true
        bro3.layer.cornerRadius = 5.0
        //firebase methods
        //TODO
        ref.observeEventType(.ChildAdded, withBlock: { snapshot in
            if(!self.newItems)  {
                return
            }
            let bool = self.myMessage
            self.sendMessage(snapshot.value as! String, currentUser: bool)
            self.myMessage = false
        })
        //makes sure not to get history
        ref.observeSingleEventOfType(.Value, withBlock: { snapshot in
            self.newItems = true
            // do some stuff once
        })
        
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    //return number of messages
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messages.count
    }
    
    //create message instance in table
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = MessageTableViewCell()
        let message = messages[indexPath.row]
        cell.addSubview(message.label)
        return cell
    }
    
    //when recieve from firebase create message label and add it to tableview
    func sendMessage(msg: String, currentUser: Bool) {
        var label: UILabel?
        let width = (CGFloat) (msg.characters.count * 15)
        if(currentUser) {
            label = UILabel(frame: CGRect(x: self.view.frame.width - 30 - width , y: 10, width: width, height: 30))
            label?.backgroundColor = UIColor.greenColor()
            label?.textColor = UIColor.whiteColor()

        }
        else {
            label = UILabel(frame: CGRect(x: 20 , y: 10, width: width, height: 30))
            label?.backgroundColor = UIColor(white: 0.3, alpha: 0.2)
        }
        label?.text = msg
        label?.clipsToBounds = true
        label?.layer.cornerRadius = 10.0
        label?.textAlignment = .Center
        label?.font = label?.font.fontWithSize(20)
        let myMessage = Message(msg: msg, user: currentUser,messageLabel: label!)
        messages.append(myMessage)
        // Insert or delete rows
        self.tableView.insertRowsAtIndexPaths([NSIndexPath(forRow: messages.count - 1, inSection: 0)], withRowAnimation: .Automatic)
        self.tableView.scrollToRowAtIndexPath(NSIndexPath(forRow: messages.count - 1, inSection: 0), atScrollPosition: .Top, animated: true)

    }
    
    //buttons to send to firebase
    @IBAction func broSend1(sender: UIButton) {
        myMessage = true
        
        //send to firebase auto id
        //TODO
        let id = ref.childByAutoId()
        id.setValue(sender.titleLabel!.text!)
    }
    
    @IBAction func broSend2(sender: UIButton) {
        myMessage = true
        
        //send to firebase auto id
        //TODO
        let id = ref.childByAutoId()
        id.setValue(sender.titleLabel!.text!)
    }
    
    
    @IBAction func broSend3(sender: UIButton) {
        myMessage = true
        
        //send to firebase auto id
        //TODO
        let id = ref.childByAutoId()
        id.setValue(sender.titleLabel!.text)
    }
    
    @IBAction func clearDatabase(sender: UIBarButtonItem) {
        
        //clear the database
        //TODO
        ref.setValue("")
        messages.removeAll()
        tableView.reloadData()
    }
    
    


}

