//
//  AuthViewController.swift
//  MatrixApp
//
//  Created by Oliver Lumby on 12/01/2017.
//  Copyright © 2017 Oliver Lumby. All rights reserved.
//

import UIKit

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

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func toggleAdvancedOptions(sender: UIButton) {
        if let view = self.advancedView, let button = self.advancedButton {
            view.isHidden = !view.isHidden
            
            if view.isHidden {
                self.advancedHeight.constant = 0
                button.setTitle("Show Advanced", for: .normal)
            } else {
                self.advancedHeight.constant = self.defaultAdvancedHeight
                button.setTitle("Hide Advanced", for: .normal)
            }
        }
    }
    
    func keyboardDidShow(notification: NSNotification) {
        if let activeField = self.activeField, let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            
            print("got here")
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
