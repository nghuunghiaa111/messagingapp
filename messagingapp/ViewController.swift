//
//  ViewController.swift
//  messagingapp
//
//  Created by Nghia Nguyen Huu on 4/8/19.
//  Copyright © 2019 Nghia Nguyen Huu. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var postData = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        tableView.delegate = self
        tableView.dataSource = self
        
        // Set the database reference
        ref = Database.database().reference()
        
        // Retrive the posts and listen for changes
        databaseHandle = ref?.child("Posts").observe(.childAdded, with: { (snapshot) in
            
            // Code to execute  when a child is added under "Posts"
            // Take the value from the snapshot and add it to the postData array
            let post = snapshot.value as? String
            if let actualPost = post {
                self.postData.append(actualPost)
                self.tableView.reloadData()
            }
            
        })
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }
    
}

