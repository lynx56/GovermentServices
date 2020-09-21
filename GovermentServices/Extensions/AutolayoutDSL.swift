//
//  AutolayoutDSL.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import UIKit

typealias PairedConstraint = (UIView, UIView) -> NSLayoutConstraint

enum ConstraintRelation {
    case equal, greaterThanOrEqual, lessThanOrEqual
}

func constraint<Anchor, AnchorType>(_ keyPath: KeyPath<UIView, Anchor>,
                                    _ otherKeyPath: KeyPath<UIView, Anchor>? = nil,
                                    constraintRelation: ConstraintRelation = .equal,
                                    constant: CGFloat = 0,
                                    priority: UILayoutPriority = .required) -> PairedConstraint where Anchor: NSLayoutAnchor<AnchorType> {
    return { view, otherView in
        var constraint: NSLayoutConstraint
        let otherKeyPath: KeyPath<UIView, Anchor> = otherKeyPath ?? keyPath
        
        switch constraintRelation {
        case .equal:
            constraint = view[keyPath: keyPath].constraint(equalTo: otherView[keyPath: otherKeyPath], constant: constant)
        case .greaterThanOrEqual:
            constraint = view[keyPath: keyPath].constraint(greaterThanOrEqualTo: otherView[keyPath: otherKeyPath], constant: constant)
        case .lessThanOrEqual:
            constraint = view[keyPath: keyPath].constraint(lessThanOrEqualTo: otherView[keyPath: otherKeyPath], constant: constant)
        }
        
        constraint.priority = priority
    
        return constraint
    }
}

extension UIView {
    func addSubview(_ child: UIView, constraints: [PairedConstraint]) {
        addSubview(child)
        child.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate(constraints.map { $0(child, self) })
    }
}

extension Array where Element == PairedConstraint {
    static var pin: [PairedConstraint] {
        return [constraint(\.topAnchor),
                constraint(\.bottomAnchor),
                constraint(\.leadingAnchor),
                constraint(\.trailingAnchor)]
    }
    
    static var centered: [PairedConstraint] {
        return [constraint(\.centerXAnchor),
                constraint(\.centerYAnchor)]
    }
}
