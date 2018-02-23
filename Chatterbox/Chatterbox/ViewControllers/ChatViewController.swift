//
//  ChatViewController.swift
//  Chatterbox
//
//  Created by Manik Narang on 2/22/18.
//  Copyright © 2018 Manik Narang. All rights reserved.
//

import UIKit
import Parse

class ChatViewController: UIViewController, UITableViewDataSource {

    @IBOutlet weak var messageTextField: UITextField!
    @IBOutlet weak var tableView: UITableView!

    var textToSave = [] as! Array<String>
    var pfobjects = [] as! Array<PFObject>
    var iLoveHacking = 0
    
    @IBAction func sendButton(_ sender: Any) {
        let chatMessage = PFObject(className: "Message")
        
        chatMessage["text"] = messageTextField.text ?? ""
        chatMessage["user"] = PFUser.current()

        chatMessage.saveInBackground { (success, error) in
            if success {
                print("The message was saved!")
            self.textToSave.append(self.messageTextField.text!)

                // Clear the text field to allow further new texts
                self.messageTextField.text = ""
            } else if let error = error {
                print("Problem saving message: \(error.localizedDescription)")
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Auto size row height based on cell autolayout constraints
        tableView.rowHeight = UITableViewAutomaticDimension
        // Provide an estimated row height. Used for calculating scroll indicator
        tableView.estimatedRowHeight = 50
        
        // Do any additional setup after loading the view.
        tableView.dataSource = self

        Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.onTimer), userInfo: nil, repeats: true)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return textToSave.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChatCell", for: indexPath) as! ChatCell

        cell.messageCellLabel.text = textToSave[indexPath.item]

        return cell
    }
    
    @objc func onTimer() {
        if (iLoveHacking == 0) {
            let query = PFQuery(className: "Message")
            query.addDescendingOrder("createdAt")
            query.findObjectsInBackground { (objects, error) in
                if error == nil {
                    if let objects = objects {
                        self.pfobjects = objects
                        
                        var i = 0
                        while (i < self.pfobjects.count) {
                            self.textToSave.append(self.pfobjects[i]["text"] as! String)
                            i = i + 1
                        }
                    }
                } else {
                    // nothing hehe
                }
            }
            iLoveHacking = iLoveHacking + 1
        }
        tableView.reloadData()
    }

}
