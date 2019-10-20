//
//  YearOfManufacture.swift
//  CarsCatalogue
//
//  Created by Ekaterina Koreneva on 19/10/2019.
//  Copyright © 2019 Ekaterina. All rights reserved.
//

import Foundation

class YearOfManufacture {
    
    private let calendar = Calendar.current
    private let date = Date()
    private lazy var currentYear = Int(calendar.component(.year, from: date))
    
    lazy var rangeForYear = 1900...currentYear
}
