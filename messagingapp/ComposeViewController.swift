//
//  ComposeViewController.swift
//  messagingapp
//
//  Created by Nghia Nguyen Huu on 4/8/19.
//  Copyright © 2019 Nghia Nguyen Huu. All rights reserved.
//

import UIKit
import FirebaseDatabase

class ComposeViewController: UIViewController {

    @IBOutlet weak var textView: UITextView!
    
    var ref: DatabaseReference?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ref = Database.database().reference()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func addPost(_ sender: Any) {
        
        // TODO: Post the data to Firebase
        let key = ref?.childByAutoId().key
        let post = ["key": key, "text": textView.text]
        ref?.child("Posts").child(key!).setValue(post)
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    @IBAction func cancelPost(_ sender: Any) {
        
        // Dismiss the popover
        presentingViewController?.dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
