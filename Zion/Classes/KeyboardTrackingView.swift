//
//  KeyboardTrackingView.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 24/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class KeyboardTrackingView: UIView {
    
    private var centerContext = 0

    override func willMove(toSuperview newSuperview: UIView?) {
        super.willMove(toSuperview: newSuperview)
        
        guard let newSuperview = newSuperview else {
            self.superview?.removeObserver(self, forKeyPath: "center")
            return
        }
        
        let options = NSKeyValueObservingOptions([.new, .old])
        newSuperview.addObserver(self, forKeyPath: "center", options: options, context: &centerContext)
    }
    
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if context == &centerContext {
            
            guard let frame = superview?.frame else {
                super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
                return
            }
            
            NotificationCenter.default.post(name: Notifications.keyboardTrackingViewCenterChanged, object: frame)
            
        } else {
            super.observeValue(forKeyPath: keyPath, of: object, change: change, context: context)
        }
    }

}
