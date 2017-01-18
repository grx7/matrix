//
//  AuthViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 12/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

import MatrixSDK

class AuthViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var errorLabel: UILabel!
    @IBOutlet weak var usernameField: BottomBorderTextField!
    @IBOutlet weak var passwordField: BottomBorderTextField!
    @IBOutlet weak var homeServerField: BottomBorderTextField!
    @IBOutlet weak var identityServerField: BottomBorderTextField!
    @IBOutlet weak var advancedView: UIView!
    @IBOutlet weak var showAdvancedButton: UIButton!
    @IBOutlet weak var advancedViewHeight: NSLayoutConstraint!
    
    let defaultAdvancedHeight: CGFloat = 176.0
    weak var activeField: UITextField?
    
    @IBAction func toggleAdvancedOptions(_ sender: UIButton) {
        self.advancedView.isHidden = !self.advancedView.isHidden
        
        if self.advancedView.isHidden {
            self.advancedViewHeight.constant = 0
            self.passwordField.returnKeyType = .go
            self.showAdvancedButton.setTitle("Show Advanced", for: .normal)
        } else {
            self.advancedViewHeight.constant = self.defaultAdvancedHeight
            self.passwordField.returnKeyType = .next
            self.showAdvancedButton.setTitle("Hide Advanced", for: .normal)
        }
        
        self.view.endEditing(true)
    }

    
    //MARK: - Keyboard Notifications
    
    func keyboardDidShow(notification: NSNotification) {
        if let activeField = self.activeField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            
            self.scrollView.contentInset = contentInsets
            self.scrollView.scrollIndicatorInsets = contentInsets
            
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            
            if (!aRect.contains(activeField.frame.origin)) {
                self.scrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        
        self.scrollView.contentInset = contentInsets
        self.scrollView.scrollIndicatorInsets = contentInsets
    }

}

//MARK: - UITextFieldDelegate

extension AuthViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeField = nil
    }
    
}
