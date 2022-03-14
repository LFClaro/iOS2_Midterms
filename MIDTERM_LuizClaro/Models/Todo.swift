//
//  Todo.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-10.
//

import Foundation

struct Todo: Hashable, Codable, Identifiable {
    var id : Int
    var name: String
    var category : String
    var date : String
    var note : String
    var smiley : String
    var completed : Bool
}
