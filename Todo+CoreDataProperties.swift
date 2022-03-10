//
//  Todo+CoreDataProperties.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-09.
//
//

import Foundation
import CoreData


extension Todo {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<Todo> {
        return NSFetchRequest<Todo>(entityName: "Todo")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var category: String?
    @NSManaged public var dateTime: Date?
    @NSManaged public var note: String?
    @NSManaged public var isCompleted: Bool
    @NSManaged public var smiley: String?

}

extension Todo : Identifiable {

}
