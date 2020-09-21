//
//  AddressCell.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell, Reusable {
    func render(_ model: AddressModel) {
        let paragraphStyle = NSMutableParagraphStyle()
        paragraphStyle.alignment = .left
        paragraphStyle.lineBreakMode = .byWordWrapping
        
        let string = [model.city, model.street, model.house, model.hotWaterStatus].joined(separator: "\r")
        
        self.textLabel?.build(DesignKit.content)
        self.textLabel?.attributedText = NSAttributedString(string: string,
                                                            attributes: [.paragraphStyle: paragraphStyle])
        
        self.imageView?.image = UIImage(named: model.image)
        self.imageView?.contentMode = .scaleAspectFit
        self.imageView?.tintColor = Palette.contentImageColor
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        self.textLabel?.attributedText = nil
        self.imageView?.image = nil
    }
}
