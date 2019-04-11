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
    @IBOutlet weak var editButtonLabel: UIBarButtonItem!
    
    var ref: DatabaseReference?
    var databaseHandle: DatabaseHandle?
    
    var check = true
    
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
    
    func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
    func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postData.count
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "PostCell")
        cell?.textLabel?.text = postData[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if (editingStyle == UITableViewCell.EditingStyle.delete) {
            postData.remove(at: indexPath.row)
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
        let temp:String = postData.remove(at: sourceIndexPath.row)
        
        postData.insert(temp, at: destinationIndexPath.row)
    }
    
    @IBAction func editButton(_ sender: Any) {
        if (check == true) {
            tableView.isEditing = true
            editButtonLabel.title = "Done"
            check = false
        }
        else {
            tableView.isEditing = false
            editButtonLabel.title = "Edit"
            check = true
        }
    }
   
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyBoard = UIStoryboard(name: "Main", bundle: nil)
        let secondVC = storyBoard.instantiateViewController(withIdentifier: "SecondViewController") as! SecondViewController
        self.navigationController?.pushViewController(secondVC, animated: true)
    }
    
}

