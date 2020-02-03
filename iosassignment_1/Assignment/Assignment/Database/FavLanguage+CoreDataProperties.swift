//
//  FavLanguage+CoreDataProperties.swift
//  Assignment
//
//  Created by Nikhil Modi on 3/7/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//
//

import Foundation
import CoreData


extension FavLanguage {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavLanguage> {
        return NSFetchRequest<FavLanguage>(entityName: "FavLanguage")
    }

    @NSManaged public var languageName: String?
    @NSManaged public var languageNative: String?

}
