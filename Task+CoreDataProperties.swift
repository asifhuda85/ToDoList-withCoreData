//
//  Task+CoreDataProperties.swift
//  ToDOAppCoredata
//
//  Created by Md Asif Huda on 3/1/17.
//  Copyright © 2017 Md Asif Huda. All rights reserved.
//

import Foundation
import CoreData


extension Task {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Task> {
        return NSFetchRequest<Task>(entityName: "Task")
    }

    @NSManaged public var text: String?

}
