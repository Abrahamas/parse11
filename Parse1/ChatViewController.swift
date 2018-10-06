//
//  ChatViewController.swift
//  Parse1
//
//  Created by Mac on 7/12/1397 AP.
//  Copyright © 1397 Abraham Asmile. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController,UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var messageField: UITextField!
    @IBOutlet weak var tableView: UITableView!
      var messages = [PFObject]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.dataSource = self
        tableView.delegate = self
        // for the cell to autoresize
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func pullMessage() {
                let query = PFQuery(className: "Message")
                      query.order(byDescending: "createdAt")
                        query.includeKey("user")
                        query.findObjectsInBackground { (objects: [PFObject]?, error: Error?) -> Void in
                           if error == nil {
                                // The find succeeded.
                            self.messages = objects!
                               self.tableView.reloadData()
                           }
                       }
    }
    

    
    @objc func onTimer() {
        
        Timer.scheduledTimer(timeInterval: 30, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
     
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return messages.count    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "MessageTableViewCell", for: indexPath) as! MessageTableViewCell
            cell.messageLabel.text = self.messages[indexPath.row]["text"] as? String
        if let user = self.messages[indexPath.row]["user"] as? PFUser {
            // User found! update username label with username
            cell.userLabel.text = user.username
        } else {
            // No user found, set default username
            cell.userLabel.text = "🤖"
        }
        return cell
    }

    func saveMessage()  {
        let chatMessage = PFObject(className: "Message")
        chatMessage["text"] = messageField.text ?? ""
        chatMessage["user"] = PFUser.current()
        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
                self.pullMessage()
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
        
        tableView.reloadData()
    }

    @IBAction func onSend(_ sender: Any) {
        saveMessage()
       
    }
    

}
