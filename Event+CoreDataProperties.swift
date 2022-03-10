//
//  Event+CoreDataProperties.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-09.
//
//

import Foundation
import CoreData


extension Event {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Event> {
        return NSFetchRequest<Event>(entityName: "Event")
    }

    @NSManaged public var startTime: Date?
    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var desc: String?
    @NSManaged public var endTime: Date?
    @NSManaged public var shouldNotify: Bool
    @NSManaged public var colour: String?

}

extension Event : Identifiable {

}
