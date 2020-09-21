//
//  LadingIndicator.swift
//  GovermentServices
//
//  Created by Holyberry on 21.09.2020.
//  Copyright © 2020 gulnaz. All rights reserved.
//

import UIKit

class LoadingIndicatorView: UIView {

    static var currentOverlay : UIView?
    static var currentOverlayTarget : UIView?
    
    static var label: UILabel?
    static var currentLoadingText: String?{
        didSet{
                label?.text = currentLoadingText
                label?.sizeToFit()
        }
    }
    
    static func show(loadingText: String? = nil) {
        guard let currentMainWindow = UIApplication.shared.keyWindow else { return }
        
        show(currentMainWindow, loadingText: loadingText)
    }
    
    static func show(overlayTarget : UIView) {
        show(overlayTarget, loadingText: nil)
    }
    
    static func show(_ overlayTarget : UIView, loadingText: String?) {
        // Clear it first in case it was already shown
        hide()
        
        // Create the overlay
        overlayTarget.layoutIfNeeded()
        let overlay = UIView(frame: overlayTarget.bounds)
        overlay.alpha = 0
        overlay.backgroundColor = Palette.overlayColor
        overlayTarget.addSubview(overlay)
        overlayTarget.bringSubviewToFront(overlay)
        
        // Create and animate the activity indicator
        let indicator = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.gray)
        indicator.center = overlay.center
        indicator.startAnimating()
        overlay.addSubview(indicator)
        
        // Create label
        if let textString = loadingText, !textString.isEmpty {
            let label = UILabel(builder: DesignKit.hint)
            label.text = textString
            label.sizeToFit()
            label.center = CGPoint(x: indicator.center.x, y: indicator.center.y + 30)
            self.label = label
            overlay.addSubview(label)
        }
        
        // Animate the overlay to show
        UIView.beginAnimations(nil, context: nil)
        UIView.setAnimationDuration(0.5)
        overlay.alpha = overlay.alpha > 0 ? 0 : 0.7
        UIView.commitAnimations()
        
        currentOverlay = overlay
        currentOverlayTarget = overlayTarget
        currentLoadingText = loadingText
    }
    
    static func hide() {
        if currentOverlay != nil {
            currentOverlay?.removeFromSuperview()
            currentOverlay =  nil
            currentLoadingText = nil
            currentOverlayTarget = nil
        }
    }
}
