//
//  Amount.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-13.
//

import Foundation

struct Amount: Hashable, Codable, Identifiable {
    var id : Int
    var name: String
    var isIncoming : Bool
    var amount : Double
    var date : String
    
    init(id: Int, name: String, isIncoming: Bool, amount: Double, date: String) {
        self.id = id
        self.name = name
        self.isIncoming = isIncoming
        self.date = date
        
        if (!self.isIncoming) {
            print("Is Outgoing!")
            self.amount = -amount
        } else {
            self.amount = amount
        }
    }
}
