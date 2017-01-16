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
    
    @IBOutlet weak var loginScrollView: UIScrollView!
    @IBOutlet weak var registerScrollView: UIScrollView!
    @IBOutlet weak var loginUsernameField: BottomBorderTextField!
    @IBOutlet weak var loginPasswordField: BottomBorderTextField!
    @IBOutlet weak var loginHomeServerField: BottomBorderTextField!
    @IBOutlet weak var loginIdentityServerField: BottomBorderTextField!
    @IBOutlet weak var loginAdvancedView: UIView!
    @IBOutlet weak var loginAdvancedButton: UIButton!
    @IBOutlet weak var loginAdvancedHeight: NSLayoutConstraint!
    @IBOutlet weak var loginButton: UIButton!
    @IBOutlet weak var registerEmailField: BottomBorderTextField!
    @IBOutlet weak var registerUsernameField: BottomBorderTextField!
    @IBOutlet weak var registerPasswordField: BottomBorderTextField!
    @IBOutlet weak var registerHomeServerField: BottomBorderTextField!
    @IBOutlet weak var registerIdentityServerField: BottomBorderTextField!
    @IBOutlet weak var registerAdvancedView: UIView!
    @IBOutlet weak var registerAdvancedButton: UIButton!
    @IBOutlet weak var registerAdvancedHeight: NSLayoutConstraint!
    @IBOutlet weak var registerButton: UIButton!
    
    let defaultAdvancedHeight: CGFloat = 176.0
    weak var activeField: UITextField?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.registerScrollView.isHidden = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        if let button = self.loginAdvancedButton {
            self.toggleAdvancedOptions(sender: button)
        }
    }
    
    @IBAction func toggleMode(sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.loginScrollView.isHidden = false
            self.registerScrollView.isHidden = true
        default:
            self.loginScrollView.isHidden = true
            self.registerScrollView.isHidden = false
        }
    }
    
    @IBAction func toggleAdvancedOptions(sender: UIButton) {
        self.loginAdvancedView.isHidden = !self.loginAdvancedView.isHidden
        self.registerAdvancedView.isHidden = !self.registerAdvancedView.isHidden
        
        if self.loginAdvancedView.isHidden {
            self.loginAdvancedHeight.constant = 0
            self.loginPasswordField.returnKeyType = .go
            self.loginAdvancedButton.setTitle("Show Advanced", for: .normal)
            
            self.registerAdvancedHeight.constant = 0
            self.registerPasswordField.returnKeyType = .go
            self.registerAdvancedButton.setTitle("Show Advanced", for: .normal)
        } else {
            self.loginAdvancedHeight.constant = self.defaultAdvancedHeight
            self.loginPasswordField.returnKeyType = .next
            self.loginAdvancedButton.setTitle("Hide Advanced", for: .normal)
            
            self.registerAdvancedHeight.constant = self.defaultAdvancedHeight
            self.registerPasswordField.returnKeyType = .next
            self.registerAdvancedButton.setTitle("Hide Advanced", for: .normal)
        }
        
        self.view.endEditing(true)
    }
    
    @IBAction func performLogin(sender: UIButton) {
        self.resignFirstResponder()
        
        if self.validateParameters() {
            _ = MatrixAccount(
                loginAndStoreUser: self.loginUsernameField.text!,
                password: self.loginPasswordField.text!,
                homeServer: AppConfig.sharedInstance.getDefault(string: self.loginHomeServerField.text, key: ConfigKey.defaultHomeServer),
                identityServer: AppConfig.sharedInstance.getDefault(string: self.loginIdentityServerField.text, key: ConfigKey.defaultIdentityServer)
            )
        }
        
    }
    
    func validateParameters() -> Bool {
        if let username = self.loginUsernameField.text, !username.isEmpty, let password = self.loginPasswordField.text, !password.isEmpty {
            return true
        }
        
        return false
    }
    
    //MARK: - Keyboard Notifications
    
    func keyboardDidShow(notification: NSNotification) {
        if let activeField = self.activeField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            let contentInsets = UIEdgeInsets(top: 0.0, left: 0.0, bottom: keyboardSize.height, right: 0.0)
            
            self.updateScrollViewInsets(insets: contentInsets)
            
            var aRect = self.view.frame
            aRect.size.height -= keyboardSize.size.height
            
            if (!aRect.contains(activeField.frame.origin)) {
                self.loginScrollView.scrollRectToVisible(activeField.frame, animated: true)
                self.registerScrollView.scrollRectToVisible(activeField.frame, animated: true)
            }
        }
    }
    
    func keyboardWillBeHidden(notification: NSNotification) {
        let contentInsets = UIEdgeInsets.zero
        
        self.updateScrollViewInsets(insets: contentInsets)
    }
    
    func updateScrollViewInsets(insets: UIEdgeInsets) {
        self.loginScrollView.contentInset = insets
        self.registerScrollView.contentInset = insets
        self.loginScrollView.scrollIndicatorInsets = insets
        self.registerScrollView.scrollIndicatorInsets = insets
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
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case self.loginUsernameField:
            self.loginPasswordField.becomeFirstResponder()
        case self.loginPasswordField:
            if self.loginAdvancedView.isHidden {
                self.performLogin(sender: self.loginButton)
            } else {
                self.loginHomeServerField.becomeFirstResponder()
            }
        case self.loginHomeServerField:
            self.loginIdentityServerField.becomeFirstResponder()
        case self.loginIdentityServerField:
            self.performLogin(sender: self.loginButton)
        case self.registerEmailField:
            self.registerUsernameField.becomeFirstResponder()
        case self.registerUsernameField:
            self.registerPasswordField.becomeFirstResponder()
        case self.registerPasswordField:
            if self.registerAdvancedView.isHidden {
                // perform register
            } else {
                self.registerHomeServerField.becomeFirstResponder()
            }
        case self.registerHomeServerField:
            self.registerIdentityServerField.becomeFirstResponder()
        case self.registerIdentityServerField:
            break
            // perform register
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}
