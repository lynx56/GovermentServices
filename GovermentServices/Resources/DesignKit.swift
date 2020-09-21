//
//  DesignKit.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import UIKit

enum DesignKit {
    static var content: (UILabel) -> Void = {
        $0.numberOfLines = 0
        $0.font = UIFont.systemFont(ofSize: 16)
        $0.textColor = UIColor.systemBlue
    }
    
    static var warning: (UILabel) -> Void = {
        $0.font = .systemFont(ofSize: 20)
        $0.textColor = .systemGray
        $0.numberOfLines = 0
        $0.textAlignment = .center
        $0.lineBreakMode = .byWordWrapping
    }
    
    static var hint: (UILabel) -> Void = {
        $0.textColor = .systemGray
        $0.textAlignment = .center
    }
}

enum Palette {
    static var activeButtonColor = UIColor.systemBlue
    
    static var contentImageColor: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemFill
        } else {
            return .black
        }
    }()
    
    static var overlayColor: UIColor = {
        if #available(iOS 13.0, *) {
            return UIColor.systemBackground
        } else {
            return .white
        }
    }()
}
