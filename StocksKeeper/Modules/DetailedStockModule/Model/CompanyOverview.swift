//
//  CompanyOverview.swift
//  StocksKeeper
//
//  Created by dev on 7.10.21.
//

import Foundation

struct CompanyOverview: Codable {
    var symbol: String
    var name: String
    var description: String
    
    var day: String
    var dayLow: String
    
    enum CodingNames: String, CodingKey {
        case symbol
        case name
        case description
        
        case day = "52WeakHigh"
        case dayLow = "50DayMovingAverage"
    }
}
