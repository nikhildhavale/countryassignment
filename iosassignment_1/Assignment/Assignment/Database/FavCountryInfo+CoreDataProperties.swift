//
//  FavCountryInfo+CoreDataProperties.swift
//  Assignment
//
//  Created by Nikhil Modi on 3/7/18.
//  Copyright © 2018 Nikhil Dhavale. All rights reserved.
//
//

import Foundation
import CoreData


extension FavCountryInfo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavCountryInfo> {
        return NSFetchRequest<FavCountryInfo>(entityName: "FavCountryInfo")
    }

    @NSManaged public var borders: String?
    @NSManaged public var currencyCode: String?
    @NSManaged public var currencyName: String?
    @NSManaged public var currencySymbol: String?
    @NSManaged public var flagURL: String?

}
