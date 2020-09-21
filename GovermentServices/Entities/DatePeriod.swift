//
//  DatePeriod.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation

enum DatePeriod {
    case saved
    case dates(DateInterval)
}

extension DatePeriod: Decodable {
    
    init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        let dates = try container.decode(String.self)
        
        if dates.caseInsensitiveCompare("ГВС сохранено") == .orderedSame {
            self = .saved
            return
        }
        
        let components = dates.components(separatedBy: "-")
        guard components.count == 2, let firstDate = components.first, let lastDate = components.last
            else { throw DecodingError.dataCorruptedError(in: container,
                                                          debugDescription: "Expected date string must contains 2 dates, but has: \(components.count)")}
        
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "dd.MM.yyyy"
        
        let from = try container.decodeDate(dateString: firstDate, with: dateFormatter)
        let to = try container.decodeDate(dateString: lastDate, with: dateFormatter)
        self = .dates(.init(start: from, end: to))
        
    }
}

