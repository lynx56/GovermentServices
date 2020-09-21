//
//  String+utf8.swift
//  GovermentServices
//
//  Created by Holyberry on 20.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation

extension String {
    var utf8Encoded: Data {
        return data(using: .utf8)!
    }
}
