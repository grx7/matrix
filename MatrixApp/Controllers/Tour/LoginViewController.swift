//
//  LoginViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 17/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var homeServerField: UITextField!
    @IBOutlet weak var identityServerField: UITextField!
    @IBOutlet weak var advancedView: UIView!
    @IBOutlet weak var showAdvancedButton: UIButton!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var advancedViewHeight: NSLayoutConstraint!
    
    let defaultAdvancedHeight: CGFloat = 176.0
    weak var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        self.toggleAdvancedOptions(self.showAdvancedButton)
    }

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
    
    @IBAction func performLogin(_ sender: UIButton) {
        
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

extension LoginViewController: UITextFieldDelegate {
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        self.activeField = textField
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        self.activeField = nil
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case self.usernameField:
            self.passwordField.becomeFirstResponder()
        case self.passwordField:
            if self.advancedView.isHidden {
                self.performLogin(self.loginButton)
            } else {
                self.homeServerField.becomeFirstResponder()
            }
        case self.homeServerField:
            self.identityServerField.becomeFirstResponder()
        case self.identityServerField:
            self.performLogin(self.loginButton)
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}

