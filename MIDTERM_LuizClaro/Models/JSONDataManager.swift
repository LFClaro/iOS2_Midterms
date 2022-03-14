//
//  TodoModelData.swift
//  MIDTERM_LuizClaro
//
//  Created by Luiz Fernando Reis on 2022-03-10.
//

import Foundation

var todos: [Todo] = load("todos.json")
var amounts: [Amount] = load("amounts.json")

func load<T: Decodable>(_ filename: String) -> T {
    let data: Data

    guard let file = Bundle.main.url(forResource: filename, withExtension: nil)
    else {
        fatalError("Couldn't find \(filename) in main bundle.")
    }

    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
    }

    do {
        let decoder = JSONDecoder()
        return try decoder.decode(T.self, from: data)
    } catch {
        fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
    }
}

class TodoDataManager: ObservableObject {
    @Published var jsonArray: [Todo] = []
    
    var fileName = "todos"
    
    init() {
        readFromFile()
    }
    
    func readFromFile() {
        jsonArray = readJSONBundle(fileName) // do this only the first time you open the app
//        readJSON() // read from the saved file
    }
    
    private func readJSONBundle<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            print(file)
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

    func saveToFile() {
        do {
            let furl = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
                .appendingPathExtension("json")
            print("---> writing to: \(furl)")
            let data = try JSONEncoder().encode(jsonArray)
            try data.write(to: furl)
        } catch {
            print("---> error saveToFile: \(error)")
        }
    }
    
    func readJSON() {
        do {
            let furl = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
                .appendingPathExtension("json")
            print("---> reading from: \(furl)")
            let data = try Data(contentsOf: furl)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([Todo].self, from: data)
            jsonArray = jsonData
        } catch {
            print("---> error reading from file: \(error)")
        }
    }
}

class AmountDataManager: ObservableObject {
    @Published var jsonArray: [Amount] = []
    
    var fileName = "amounts"
    
    init() {
        readFromFile()
    }
    
    func readFromFile() {
        jsonArray = readJSONBundle(fileName) // do this only the first time you open the app
//        readJSON() // read from the saved file
    }
    
    private func readJSONBundle<T: Decodable>(_ filename: String) -> T {
        let data: Data
        
        guard let file = Bundle.main.url(forResource: filename, withExtension: "json")
        else {
            fatalError("Couldn't find \(filename) in main bundle.")
        }
        do {
            print(file)
            data = try Data(contentsOf: file)
        } catch {
            fatalError("Couldn't load \(filename) from main bundle:\n\(error)")
        }
        do {
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode(T.self, from: data)
            return jsonData
        } catch {
            fatalError("Couldn't parse \(filename) as \(T.self):\n\(error)")
        }
    }

    func saveToFile() {
        do {
            let furl = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
                .appendingPathExtension("json")
            print("---> writing to: \(furl)")
            let data = try JSONEncoder().encode(jsonArray)
            try data.write(to: furl)
        } catch {
            print("---> error saveToFile: \(error)")
        }
    }
    
    func readJSON() {
        do {
            let furl = try FileManager.default
                .url(for: .documentDirectory, in: .userDomainMask, appropriateFor: nil, create: true)
                .appendingPathComponent(fileName)
                .appendingPathExtension("json")
            print("---> reading from: \(furl)")
            let data = try Data(contentsOf: furl)
            let decoder = JSONDecoder()
            let jsonData = try decoder.decode([Amount].self, from: data)
            jsonArray = jsonData
        } catch {
            print("---> error reading from file: \(error)")
        }
    }
}
