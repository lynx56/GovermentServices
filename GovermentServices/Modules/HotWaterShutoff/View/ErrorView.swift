//
//  ErrorView.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import UIKit

class ErrorView: UIView {
    private lazy var textLabel = UILabel(builder: DesignKit.warning)
    
    private (set) lazy var retryButton: UIButton = {
        let button = UIButton()
        button.tintColor = Palette.activeButtonColor
        
        if #available(iOS 13.0, *) {
            let image = UIImage(systemName: "arrow.counterclockwise")?
                .applyingSymbolConfiguration(.init(pointSize: Constants.buttonSize))
            button.setImage(image, for: .normal)
            button.setTitle(nil, for: .normal)
        } else {
            button.setTitle(L10n.HotWaterShutoff.retry, for: .normal)
        }
        
        return button
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setup() {
        let stack = UIStackView(arrangedSubviews: [textLabel, retryButton])
        stack.axis = .vertical
        stack.spacing = Constants.spacing
        addSubview(stack, constraints: .centered)
    }
    
    func render(text: String) {
        textLabel.text = text
        textLabel.sizeToFit()
    }
    
    enum Constants {
        static let spacing = CGFloat(20)
        static let buttonSize = CGFloat(26)
    }
}
