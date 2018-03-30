//
//  LoginViewController.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/14/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    
    @IBOutlet weak var guestButton: UIButton!
    @IBOutlet weak var adminButton: UIButton!
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var borderView: UIView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        adminButton.layer.cornerRadius = 6.0
        adminButton.clipsToBounds = true
        setDoneOnKeyboard()
        textField.isHidden = true
        borderView.isHidden = true
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(QuestionTableViewCell.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textField.inputAccessoryView = keyboardToolbar
    }
    
    @objc func dismissKeyboard() {
        if textField.text?.lowercased() == "sry" {
            presentScene()
        }
        textField.resignFirstResponder()
        textField.isHidden = true
        borderView.isHidden = true
    }
    
    @IBAction func guestClick(_ sender: Any) {
        ViewController.isAdmin = false
        presentScene()
    }
    
    @IBAction func adminClick(_ sender: Any) {
        textField.isHidden = false
        borderView.isHidden = false
        textField.becomeFirstResponder()
    }
    
    func presentScene() {
        guard let vc = storyboard?.instantiateViewController(withIdentifier: "TabBarVC") else {return}
        present(vc, animated: true, completion: nil)
    }
    
}
