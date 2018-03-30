//
//  QuestionTableViewCell.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/8/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class QuestionTableViewCell: UITableViewCell {

    @IBOutlet weak var textView: UITextView!
    weak var vc: ViewController?

    override func awakeFromNib() {
        super.awakeFromNib()
        textView.delegate = self
        setDoneOnKeyboard()
    }
    
    func setDoneOnKeyboard() {
        let keyboardToolbar = UIToolbar()
        keyboardToolbar.sizeToFit()
        let flexBarButton = UIBarButtonItem(barButtonSystemItem: .flexibleSpace, target: nil, action: nil)
        let doneBarButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(QuestionTableViewCell.dismissKeyboard))
        keyboardToolbar.items = [flexBarButton, doneBarButton]
        textView.inputAccessoryView = keyboardToolbar
    }
    
    @objc func dismissKeyboard() {
        textView.resignFirstResponder()
    }

}
extension QuestionTableViewCell: UITextViewDelegate {
    func textViewDidEndEditing(_ textView: UITextView) {
        guard let text = textView.text else {return}
        vc?.questionAnswered(string: text)
    }
}
