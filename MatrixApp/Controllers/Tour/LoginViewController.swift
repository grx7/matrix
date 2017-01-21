//
//  LoginViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 17/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

class LoginViewController: AuthViewController {

    @IBOutlet weak var loginButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func performLogin(_ sender: UIButton) {
        self.view.endEditing(true)

        if self.validateParameters() {
            self.showButtonLoading(loading: true, button: self.loginButton)

            // TODO: FixME
//            MatrixAccountManager.sharedInstance.addAccount(
//                username: self.usernameField.text!,
//                password: self.passwordField.text!,
//                homeServer: AppConfig.sharedInstance.getDefault(string: self.homeServerField.text, key: ConfigKey.defaultHomeServer),
//                identityServer: AppConfig.sharedInstance.getDefault(string: self.identityServerField.text, key: ConfigKey.defaultIdentityServer),
//                success: { (account) in }, failure: { (error) in
//                    self.errorLabel.text = error.localizedDescription.localizedCapitalized
//                    self.showButtonLoading(loading: false, button: self.loginButton)
//            })
        }
    }
    
    func validateParameters() -> Bool {
        if let username = self.usernameField.text, !username.isEmpty, let password = self.passwordField.text, !password.isEmpty {
            return true
        }
        
        return false
    }

}

//MARK: - UITextFieldDelegate

extension LoginViewController {
    
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

