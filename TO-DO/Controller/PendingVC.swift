//
//  ViewController.swift
//  TO-DO
//
//  Created by Suresh Kansujiya on 23/08/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit
import CoreData

class PendingVC : UIViewController {

    @IBOutlet weak var tableViewPending : UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    var arrPendingTasks : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewPending?.dataSource = self
        tableViewPending?.delegate = self
        tableViewPending?.tableFooterView = UIView()
    }
    
    override func viewDidAppear(animated: Bool)
    {
        super.viewDidAppear(animated)
        activityIndicator?.stopAnimating()
            self.fetchTaskResult()
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: FetchData
    
    func fetchTaskResult()
    {
        activityIndicator?.stopAnimating()
        activityIndicator?.hidesWhenStopped = true
        arrPendingTasks = Task.getTaskDatasource("0")
        
        if arrPendingTasks?.count > 0
        {
            for task  in arrPendingTasks!
            {
                let checkTask = task as! Task
                if checkTask.isCancelBtnShown == true
                {
                    checkTask.isCancelBtnShown = false
                }
            }
        }
        tableViewPending?.reloadData()
    }
}

