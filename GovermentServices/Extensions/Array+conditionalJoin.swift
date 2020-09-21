//
//  File.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation

extension Array where Element == String {
    
    func conditionalJoin(condition: (Self) -> Bool, separator: String = " ") -> String {
        if condition(self) {
            return joined(separator: separator)
        }
        
        return ""
    }
}
