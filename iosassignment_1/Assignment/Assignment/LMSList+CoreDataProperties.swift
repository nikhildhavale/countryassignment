//
//  LMSList+CoreDataProperties.swift
//  
//
//  Created by Nikhil d on 03/02/20.
//
//

import Foundation
import CoreData


extension LMSList {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<LMSList> {
        return NSFetchRequest<LMSList>(entityName: "LMSList")
    }

    @NSManaged public var type: String?
    @NSManaged public var lMSMaster: NSOrderedSet?

}

// MARK: Generated accessors for lMSMaster
extension LMSList {

    @objc(insertObject:inLMSMasterAtIndex:)
    @NSManaged public func insertIntoLMSMaster(_ value: LMSMaster, at idx: Int)

    @objc(removeObjectFromLMSMasterAtIndex:)
    @NSManaged public func removeFromLMSMaster(at idx: Int)

    @objc(insertLMSMaster:atIndexes:)
    @NSManaged public func insertIntoLMSMaster(_ values: [LMSMaster], at indexes: NSIndexSet)

    @objc(removeLMSMasterAtIndexes:)
    @NSManaged public func removeFromLMSMaster(at indexes: NSIndexSet)

    @objc(replaceObjectInLMSMasterAtIndex:withObject:)
    @NSManaged public func replaceLMSMaster(at idx: Int, with value: LMSMaster)

    @objc(replaceLMSMasterAtIndexes:withLMSMaster:)
    @NSManaged public func replaceLMSMaster(at indexes: NSIndexSet, with values: [LMSMaster])

    @objc(addLMSMasterObject:)
    @NSManaged public func addToLMSMaster(_ value: LMSMaster)

    @objc(removeLMSMasterObject:)
    @NSManaged public func removeFromLMSMaster(_ value: LMSMaster)

    @objc(addLMSMaster:)
    @NSManaged public func addToLMSMaster(_ values: NSOrderedSet)

    @objc(removeLMSMaster:)
    @NSManaged public func removeFromLMSMaster(_ values: NSOrderedSet)

}
