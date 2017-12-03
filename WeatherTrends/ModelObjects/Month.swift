//
//  Month.swift
//  WeatherTrends
//
//  Created by Dima Komar  on 11/30/17.
//  Copyright © 2017 Dima Komar . All rights reserved.
//

import Foundation

enum ChartType {
    case tMax
    case tMin
    case afDays
    case rainMm
    case sunHours
}

struct MonthList : Codable {
    let months: [Month]
    
    enum CodingKeys: String, CodingKey {
        case months
    }
}

struct Month: Codable {
    let year: Int
    let month: Int
    let tMax: String
    let tMin: String
    let afDays: String
    let rainMm: String
    let sunHours: String
    
    enum CodingKeys: String, CodingKey {
        case year
        case month
        case tMax = "t_max"
        case tMin = "t_min"
        case afDays = "af_days"
        case rainMm = "rain_mm"
        case sunHours = "sun_hours"
    }
}

struct MonthWithProperties {
    let year: Int
    let month: Int
    let tMax: FloatMonthValue
    let tMin: FloatMonthValue
    let afDays: FloatMonthValue
    let rainMm: FloatMonthValue
    let sunHours: FloatMonthValue
}

struct FloatMonthValue {
    let value: CGFloat
    let isEstimated: Bool
}


extension Encodable {
    func encode(with encoder: JSONEncoder = JSONEncoder()) throws -> Data {
        return try encoder.encode(self)
    }
}

extension Decodable {
    static func decode(with decoder: JSONDecoder = JSONDecoder(), from data: Data) throws -> Self {
        return try decoder.decode(Self.self, from: data)
    }
}
