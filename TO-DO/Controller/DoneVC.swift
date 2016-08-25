//
//  ViewController.swift
//  TO-DO
//
//  Created by Suresh Kansujiya on 23/08/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit
import CoreData

class DoneVC: UIViewController {

    @IBOutlet weak var tableViewDone : UITableView?
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
    
    var refreshData : Bool = false
    
    var arrDoneTasks : NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        tableViewDone?.tableFooterView = UIView()
       hitRequestForTaskAPI()
        
        
    }
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        if refreshData == true{
            self.fetchTaskResult()
        }
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
 
    /** hit api for get task */
    func hitRequestForTaskAPI()
    {
        if Reachability.isConnectedToNetwork()
        {
        activityIndicator?.startAnimating()
        Service.instance.GETREQUEST(kApiPath,parameters: nil, headers: nil)
        {
            (success, dictionary, error) -> () in
            if success == true
            {
                let taskArray: NSArray? = dictionary!["data"] as? NSArray
                if taskArray?.count > 0
                {
                    Task.insertOrUpdateTaskData(taskArray!)
                    self.fetchTaskResult()
                    self.refreshData = true
                    
                }
            }
            else
            {
                self.refreshData = true
                self.activityIndicator?.stopAnimating()
                self.activityIndicator?.hidesWhenStopped = true
            }
            }
        }
        else
        {
            self.refreshData = true
        }
    }

    //MARK: FetchData
    
    func fetchTaskResult() {
    
        activityIndicator?.stopAnimating()
        activityIndicator?.hidesWhenStopped = true
        arrDoneTasks = Task.getTaskDatasource("1")
        
        if arrDoneTasks?.count > 0
        {
            for task  in arrDoneTasks!
            {
                let checkTask = task as! Task
                if checkTask.isCancelBtnShown == true
                {
                    checkTask.isCancelBtnShown = false
                }
            }
        }
        tableViewDone?.dataSource = self
        tableViewDone?.delegate = self
        tableViewDone?.reloadData()
    }
    
}

