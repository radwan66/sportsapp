//
//  Leaguess+CoreDataProperties.swift
//  
//
//  Created by radwan on 31/01/20224.
//
//

import Foundation
import CoreData


extension Leaguess {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Leaguess> {
        return NSFetchRequest<Leaguess>(entityName: "Leaguess")
    }

    @NSManaged public var league_key: Int32
    @NSManaged public var league_logo: Data?
    @NSManaged public var league_name: String?
    @NSManaged public var league_sportName: String?

}
