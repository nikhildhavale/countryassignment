//
//  FavCountry+CoreDataProperties.swift
//  Assignment
//
//  Created by Nikhil d on 05/02/20.
//  Copyright © 2020 Nikhil Dhavale. All rights reserved.
//
//

import Foundation
import CoreData


extension FavCountry {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<FavCountry> {
        return NSFetchRequest<FavCountry>(entityName: "FavCountry")
    }

    @NSManaged public var capital: String?
    @NSManaged public var name: String?
    @NSManaged public var region: String?
    @NSManaged public var info: FavCountryInfo?
    @NSManaged public var languages: NSOrderedSet?
    /// Return AttributedString to show info in item cell
    func getBasicInfo() -> NSMutableAttributedString{
        let countryInfo = NSMutableAttributedString()
        if name != nil {
            let countryName = NSAttributedString(string: name!, attributes: [NSAttributedString.Key.foregroundColor:UIColor.black,NSAttributedString.Key.font:FontConstant.defaultBoldFont])
            countryInfo.append(countryName)
        }
        countryInfo.append(NSAttributedString.itemNonBoldAttributedString(string: capital))
        countryInfo.append(NSAttributedString.itemNonBoldAttributedString(string: region))
        return countryInfo
    }
    /// Show complete country info used in country detail
    func getCompleteInfo() -> NSMutableAttributedString{
        let completeCountryInfoString = NSMutableAttributedString()
        /// country name
        completeCountryInfoString.append(NSAttributedString.mainAttributedString(string: name))
        
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: capital))
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: region))
        // currency info
        completeCountryInfoString.append(NSAttributedString.mainAttributedString(string: "Currency"))
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: info?.currencyName))
        
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: info?.currencyCode))
        completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: info?.currencySymbol))
        
        //language
        if let languageSet = languages {
            completeCountryInfoString.append(NSAttributedString.mainAttributedString(string: "Language"))
            for language in languageSet {
                if let favLanguage = language as? FavLanguage{
                    completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: favLanguage.languageName))
                    completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: favLanguage.languageNative))

                }
            }
        }
        if let borders = info?.borders {
            completeCountryInfoString.append(NSAttributedString.mainAttributedString(string: "Borders"))
            let borderArray = borders.components(separatedBy: ",")
            for borderString in borderArray {
                completeCountryInfoString.append(NSAttributedString.itemAttributedString(string: borderString))
            }
        }
        return completeCountryInfoString
    }
}

// MARK: Generated accessors for languages
extension FavCountry {

    @objc(insertObject:inLanguagesAtIndex:)
    @NSManaged public func insertIntoLanguages(_ value: FavLanguage, at idx: Int)

    @objc(removeObjectFromLanguagesAtIndex:)
    @NSManaged public func removeFromLanguages(at idx: Int)

    @objc(insertLanguages:atIndexes:)
    @NSManaged public func insertIntoLanguages(_ values: [FavLanguage], at indexes: NSIndexSet)

    @objc(removeLanguagesAtIndexes:)
    @NSManaged public func removeFromLanguages(at indexes: NSIndexSet)

    @objc(replaceObjectInLanguagesAtIndex:withObject:)
    @NSManaged public func replaceLanguages(at idx: Int, with value: FavLanguage)

    @objc(replaceLanguagesAtIndexes:withLanguages:)
    @NSManaged public func replaceLanguages(at indexes: NSIndexSet, with values: [FavLanguage])

    @objc(addLanguagesObject:)
    @NSManaged public func addToLanguages(_ value: FavLanguage)

    @objc(removeLanguagesObject:)
    @NSManaged public func removeFromLanguages(_ value: FavLanguage)

    @objc(addLanguages:)
    @NSManaged public func addToLanguages(_ values: NSOrderedSet)

    @objc(removeLanguages:)
    @NSManaged public func removeFromLanguages(_ values: NSOrderedSet)

}
