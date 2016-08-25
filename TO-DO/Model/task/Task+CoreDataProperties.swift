//
//  Task+CoreDataProperties.swift
//  TO-DO
//
//  Created by Suresh Kansujiya on 26/08/16.
//  Copyright © 2016 Suresh Kansujiya. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

import Foundation
import CoreData

extension Task {

    @NSManaged var id: NSNumber?
    @NSManaged var name: String?
    @NSManaged var state: NSNumber?
}
