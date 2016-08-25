//
//  AddToDoViewController.swift
//  Done
//
//  Created by Bart Jacobs on 19/10/15.
//  Copyright © 2015 Envato Tuts+. All rights reserved.
//

import UIKit
import CoreData

class AddToDoViewController: UIViewController, UITextFieldDelegate {

    @IBOutlet weak var textField: UITextField!
    
    @IBOutlet weak var btnSave: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    // MARK: -
    // MARK: Actions
    @IBAction func cancel(sender: AnyObject) {
        self.navigationController?.popViewControllerAnimated(true)
    }
    
    @IBAction func save(sender: AnyObject)
    {
        let name  = textField.text
        
        
        if let isEmpty = name?.isEmpty where isEmpty == false {
            let task = Task.initializTask()
            task.name = name
            task.state = 0
            let random = NSNumber(unsignedInt: arc4random_uniform(999))
            task.id = random
            CoreDataEngine.sharedCoreDataEngine.saveContext()
           self.navigationController?.popViewControllerAnimated(true)
            
        } else {
            // Show Alert View
            showAlertWithTitle("Warning", message: "Your to-do task needs a name.", cancelButtonTitle: "OK")
        }
    }
    
    // MARK: -
    // MARK: Helper Methods
    private func showAlertWithTitle(title: String, message: String, cancelButtonTitle: String) {
        // Initialize Alert Controller
        let alertController = UIAlertController(title: title, message: message, preferredStyle: .Alert)
        
        // Configure Alert Controller
        alertController.addAction(UIAlertAction(title: cancelButtonTitle, style: .Default, handler: nil))
        
        // Present Alert Controller
        presentViewController(alertController, animated: true, completion: nil)
    }
}
