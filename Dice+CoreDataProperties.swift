//
//  Die+CoreDataProperties.swift
//  RollDice
//
//  Created by mr. Hakoda on 27.02.2021.
//
//

import Foundation
import CoreData


extension Die {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Die> {
        return NSFetchRequest<Die>(entityName: "Die")
    }

    @NSManaged public var five: String?
    @NSManaged public var four: String?
    @NSManaged public var one: String?
    @NSManaged public var three: String?
    @NSManaged public var two: String?
    @NSManaged public var date: Date?

}

extension Die : Identifiable {

}
