//
//  Bundle+keys.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import Foundation

extension Bundle {
    var host: URL {
        return URL(string: self.object(forInfoDictionaryKey: "host") as! String)!
    }
}
