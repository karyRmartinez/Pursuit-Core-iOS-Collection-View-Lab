//
//  structs.swift
//  Collection-View-Lab
//
//  Created by Kary Martinez on 9/26/19.
//  Copyright © 2019 Kary Martinez. All rights reserved.
//

import Foundation

struct Country: Codable {
    let name: String
    let capital: String
    let population: Int
    
    static func decodeCountryFromData(from jsonData: Data) throws -> [Country] {
        let response = try JSONDecoder().decode([Country].self, from: jsonData)
        return response
    }
}