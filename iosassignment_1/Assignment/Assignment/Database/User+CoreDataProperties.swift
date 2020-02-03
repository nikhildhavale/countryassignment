//
//  User+CoreDataProperties.swift
//  Assignment
//
//  Created by Nikhil Modi on 3/6/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//
//

import Foundation
import CoreData


extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var email: String?
    @NSManaged public var password: String?

}
