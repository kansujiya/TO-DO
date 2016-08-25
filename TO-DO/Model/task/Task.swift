//
//  Task.swift
//  TO-DO
//
//  Created by Suresh Kansujiya on 24/08/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//

import Foundation
import CoreData
import Alamofire

class Task: NSManagedObject {

    var isCancelBtnShown : Bool = false
    
// Insert code here to add functionality to your managed object subclass
    /**  this function initialize the new entity to insert in the managecontex*/
    
    class func initializTask()-> Task {
        let task = NSEntityDescription.insertNewObjectForEntityForName("Task", inManagedObjectContext: CoreDataEngine.sharedCoreDataEngine.managedObjectContext) as! Task
        return task
    }
    
    
    class func getTaskDatasource(state : String)->NSMutableArray? {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "state == \(state)")
       
        do {
            let resultArr = try CoreDataEngine.sharedCoreDataEngine.managedObjectContext.executeFetchRequest(fetchRequest)
            if resultArr.count > 0 {
               let arrResult = resultArr as NSArray
               return  arrResult.mutableCopy() as? NSMutableArray
                
            }
            else {
                return nil
            }
        }
        catch let error as NSError {
            Swift.debugPrint(error)
        }
        return nil
        
    }
    
    class func  insertOrUpdateTaskData(dataSource : NSArray)
    {
        for dic in dataSource {
            let taskId = dic.objectForKey(kId) as? Int
            /** check if Task object is already in the Task entity if it is then update that object , else insert a new Task object*/
            if  let task = isTaskAlreadyAvailable(taskId!) {
                //update task object
                insertOrUpdateTaskDetails(task, taskDic: dic as! NSDictionary)
            }
            else {
                // insert a new task object
                let task = initializTask()
                insertOrUpdateTaskDetails(task ,taskDic:  dic as! NSDictionary)
            }
        }
        // update or insert lastUpdated Date in UpdateRecord Table
        //Issue.updateRecord(dataSource, withApiType: apiType)
    }
    
    class func insertOrUpdateTaskDetails(task : Task, taskDic : NSDictionary) {
        task.id = taskDic.valueForKey(kId) as? NSNumber
        task.name = taskDic.objectForKey(kName) as? String
        task.state = taskDic.objectForKey(kState) as? NSNumber
        CoreDataEngine.sharedCoreDataEngine.saveContext()
    }


    class func isTaskAlreadyAvailable(taskId : Int)->Task?
    {
        let fetchRequest = NSFetchRequest(entityName: "Task")
        fetchRequest.predicate = NSPredicate(format: "id = % d", taskId)
        fetchRequest.fetchLimit = 1
        do {
            let resultArr = try CoreDataEngine.sharedCoreDataEngine.managedObjectContext.executeFetchRequest(fetchRequest)
            if resultArr.count > 0 {
                return resultArr[0] as? Task
            }
            else {
                return nil
            }
        }
        catch let error as NSError {
            Swift.debugPrint(error)
        }
        return nil
    }

}
