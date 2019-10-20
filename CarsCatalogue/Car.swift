//
//  Car.swift
//  CarsCatalogue
//
//  Created by Ekaterina Koreneva on 04/10/2019.
//  Copyright © 2019 Ekaterina. All rights reserved.
//

import Foundation

public struct Car: Codable {
    
    var yearOfManufacture: String
    var brand: String
    var model: String
    var bodyType: String
    
    private enum CodingKeys: String, CodingKey {
        case yearOfManufacture
        case brand
        case model
        case bodyType
    }
    
    public init(yearOfManufacture: String, brand: String, model: String, bodyType: String) {
        self.yearOfManufacture = yearOfManufacture
        self.brand = brand
        self.model = model
        self.bodyType = bodyType
    }
    
    public func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(yearOfManufacture, forKey: .yearOfManufacture)
        try container.encode(brand, forKey: .brand)
        try container.encode(model, forKey: .model)
        try container.encode(bodyType, forKey: .bodyType)
    }

    public init(from decoder: Decoder) throws {
        do {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.yearOfManufacture =  try container.decode(String.self, forKey: .yearOfManufacture)
        self.brand =  try container.decode(String.self, forKey: .brand)
        self.model =  try container.decode(String.self, forKey: .model)
        self.bodyType =  try container.decode(String.self, forKey: .bodyType)
            } catch {
        NSLog("ERROR \(error.localizedDescription)")
                self.yearOfManufacture = ""
                self.brand = ""
                self.model = ""
                self.bodyType = ""
        }
    }
}

extension Car: Hashable {
    public static func == (lhs: Car, rhs: Car) -> Bool {
        return lhs.hashValue == rhs.hashValue
    }
}
