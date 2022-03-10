//
//  AccountTransaction+CoreDataProperties.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-09.
//
//

import Foundation
import CoreData


extension AccountTransaction {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AccountTransaction> {
        return NSFetchRequest<AccountTransaction>(entityName: "AccountTransaction")
    }

    @NSManaged public var id: UUID?
    @NSManaged public var title: String?
    @NSManaged public var isCredit: Bool
    @NSManaged public var category: String?
    @NSManaged public var dateTime: Date?

}

extension AccountTransaction : Identifiable {

}
