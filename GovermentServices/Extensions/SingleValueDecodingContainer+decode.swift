//
//  File.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation

extension SingleValueDecodingContainer {
    func decodeDate(dateString: String, with formatter: DateFormatter) throws -> Date {
        let preparedDate = dateString.components(separatedBy: .whitespaces).first!
        
        guard let parsedDate = formatter.date(from: preparedDate) else {
            throw DecodingError.dataCorruptedError(in: self,
                                                   debugDescription: "Can't parse date string: \(dateString)") }
        return parsedDate
    }
}
