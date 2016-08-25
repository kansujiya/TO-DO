//
//  DoneVC+TableViewDataSource.swift
//  TO-DO
//
//  Created by Suresh Kansujiya on 24/08/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import UIKit
import CoreData

let tableCellHeight : CGFloat = 80

extension DoneVC: UITableViewDataSource {
    
    func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        return tableCellHeight
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = arrDoneTasks?.count {
            return count
        }
        return 0
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell
    {
        var cell = tableView.dequeueReusableCellWithIdentifier(kTaskTableCell) as? TaskCell
        
        if cell == nil
        {
            cell = UITableViewCell(style: UITableViewCellStyle.Value1, reuseIdentifier:kTaskTableCell) as? TaskCell
        }
        
        let task = arrDoneTasks!.objectAtIndex(indexPath.row) as! Task
        //task.isCancelBtnShown = false
        cell?.populateData(task)
        return cell!
    }
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool
    {
        let task = arrDoneTasks!.objectAtIndex(indexPath.row) as! Task
        if task.isCancelBtnShown == true
        {
            return false
        }
        return true
    }
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath)
    {
        if editingStyle == .Delete
        {
            let task = arrDoneTasks!.objectAtIndex(indexPath.row) as! Task
            CoreDataEngine.sharedCoreDataEngine.managedObjectContext.deleteObject(task as NSManagedObject)
            CoreDataEngine.sharedCoreDataEngine.saveContext()
            arrDoneTasks?.removeObjectAtIndex(indexPath.row)
            tableViewDone!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        }
    }
}

extension DoneVC: UITableViewDelegate
{
    func transitionStateOfTask(timer : NSTimer)
    {
        let task = timer.userInfo as! Task
        
        if task.isCancelBtnShown == false {
            return
        }
        
        task.state = 0
        CoreDataEngine.sharedCoreDataEngine.saveContext()
        
        let index = arrDoneTasks?.indexOfObject(task)
        let indexPath = NSIndexPath(forRow: index!, inSection: 0)
        arrDoneTasks?.removeObjectAtIndex(indexPath.row)
        tableViewDone!.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Fade)
        
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath)
    {
        tableView.deselectRowAtIndexPath(indexPath, animated: false)
        let task = arrDoneTasks!.objectAtIndex(indexPath.row) as! Task
        if(task.isCancelBtnShown){
            return
        }
        else{
            task.isCancelBtnShown = true
            let cell = tableView.cellForRowAtIndexPath(indexPath) as? TaskCell
            cell?.updateBtnCancelState(task)
        }
        NSTimer.scheduledTimerWithTimeInterval(5.0, target: self, selector: #selector(DoneVC.transitionStateOfTask), userInfo: task, repeats: false)
    }
}

