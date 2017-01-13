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
    @IBOutlet weak var usernameField: BottomBorderTextField!
    @IBOutlet weak var passwordField: BottomBorderTextField!
    @IBOutlet weak var homeServerField: BottomBorderTextField!
    @IBOutlet weak var identityServerField: BottomBorderTextField!
    @IBOutlet weak var advancedView: UIView!
    @IBOutlet weak var advancedButton: UIButton!
    @IBOutlet weak var advancedHeight: NSLayoutConstraint!
    
    let defaultAdvancedHeight: CGFloat = 176.0
    weak var activeField: UITextField?
    

    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        if let button = self.advancedButton {
            self.toggleAdvancedOptions(sender: button)
        }
        
        MatrixAccount(credentials: MXCredentials())
    }
    
    @IBAction func toggleAdvancedOptions(sender: UIButton) {
        self.advancedView.isHidden = !view.isHidden
        
        if self.advancedView.isHidden {
            self.advancedHeight.constant = 0
            self.advancedButton.setTitle("Show Advanced", for: .normal)
        } else {
            self.advancedHeight.constant = self.defaultAdvancedHeight
            self.advancedButton.setTitle("Hide Advanced", for: .normal)
        }
    }
    
    @IBAction func performLogin(sender: UIButton) {
        
        print("Username: \(self.usernameField.text), Password: \(self.passwordField.text)")
        
    }
    
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
