//
//  DoneVC+TableViewDataSource.swift
//  TO-DO
//
//  Created by Suresh Kansujiya on 24/08/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//
//

import UIKit
import Alamofire

class Service: NSObject {
    
    var reachability: Reachability?
    static let instance = Service()
    
    enum Method: String
    {
        case GET_REQUEST = "GET"
        case POST_REQUEST = "POST"
        case PUT_REQUEST = "PUT"
        case DELETE_REQUEST = "DELETE"
    }
    
    func GETREQUEST(URLString: String, parameters: [String : AnyObject]?, headers:  [String: String]? ,completionHandler: (success:Bool!,NSDictionary?, NSError?) -> ()) {
        
        // Allocate a reachability object
        do {
            let reachability = try Reachability.reachabilityForInternetConnection()
            self.reachability = reachability
        } catch ReachabilityError.FailedToCreateWithAddress(let address) {
            self.reachability = nil
            print("Unable to create\nReachability with address:\n\(address)")
        } catch {}
        
        // Initial reachability check
        if let reachability = reachability
        {
            if reachability.isReachable()
            {
                var kApiURL = URLString
                /*SourcePath.SourcePathinstance.baseApiUrl()
                kApiURL += URLString;*/
                Alamofire.request(.GET, kApiURL, parameters: parameters, encoding:.JSON, headers: headers).response(completionHandler: { (request, response, data, error) -> Void in
                    kApiURL = ""
                    do
                    {
                        if (error == nil)
                        {
                            if let jsonResult = try NSJSONSerialization.JSONObjectWithData(data!, options: []) as? NSDictionary
                            {
                                print(jsonResult)
                                //Loader.removeLoader()
                                completionHandler(success: true, jsonResult, nil)
                            }
                            else
                            {
                                completionHandler(success: false, nil, nil)
                            }
                        }
                        else
                        {
                            completionHandler(success: false, nil, error)
                        }
                    } catch let error as NSError
                    {
                        print(error)
                        completionHandler(success: false, nil, nil)
                    }
                })
            }
            else {
                NSNotificationCenter.defaultCenter().addObserver(self, selector: "reachabilityChanged:", name: ReachabilityChangedNotification, object: reachability)
                do
                {
                    try reachability.startNotifier()
                } catch {
                    return
                }
                completionHandler(success: false, nil,  NSError(domain:"internetError", code:9000, userInfo: nil))
                
            }
        }
        
    }
    
    
    func reachabilityChanged(note: NSNotification) {
        let reachability = note.object as! Reachability
        if reachability.isReachable()
        {
            //NSNotificationCenter.defaultCenter().postNotificationName(InternetChangedNotification, object:nil)
        }
        else{
            //NSNotificationCenter.defaultCenter().postNotificationName(InternetChangedNotification, object:nil)
        }
    }
}

