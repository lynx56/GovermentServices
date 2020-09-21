//
//  UILabel+build.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import UIKit

extension UILabel {
    convenience init(builder: (UILabel) -> Void) {
        self.init()
        build(builder)
    }
    
    func build(_ builder: (UILabel) -> Void) {
        builder(self)
    }
}
