//
//  RegisterViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 17/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class RegisterViewController: AuthViewController {

    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var registerButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardDidShow(notification:)), name: .UIKeyboardDidShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(self.keyboardWillBeHidden(notification:)), name: .UIKeyboardWillHide, object: nil)
        
        self.toggleAdvancedOptions(self.showAdvancedButton)
    }
    
    @IBAction func performRegistration(_ sender: UIButton) {
        self.view.endEditing(true)
    }

}

//MARK: - UITextFieldDelegate

extension RegisterViewController {
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
        switch textField {
        case self.emailField:
            self.usernameField.becomeFirstResponder()
        case self.usernameField:
            self.passwordField.becomeFirstResponder()
        case self.passwordField:
            if self.advancedView.isHidden {
                self.performRegistration(self.registerButton)
            } else {
                self.homeServerField.becomeFirstResponder()
            }
        case self.homeServerField:
            self.identityServerField.becomeFirstResponder()
        case self.identityServerField:
            self.performRegistration(self.registerButton)
        default:
            textField.resignFirstResponder()
        }
        
        return true
    }
    
}

