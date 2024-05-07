//
//  Continents.swift
//  GraphQLURLSession
//
//  Created by WhyQ on 03/05/24.
//

import Foundation
class Continents: Decodable {
    let code : String
    let name : String
    
    init(code:String, name:String) {
        self.code = code
        self.name = name
    }
    
}

class DataModelContinents:Decodable {
    var continents = [Continents]()
    init(continents: [Continents] = [Continents]()) {
        self.continents = continents
    }
}

class DataModel:Decodable {
    var data = DataModelContinents()
    init(data: DataModelContinents = DataModelContinents()) {
        self.data = data
    }
}
