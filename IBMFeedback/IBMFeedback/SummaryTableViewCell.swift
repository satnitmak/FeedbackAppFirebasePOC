//
//  SummaryTableViewCell.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/9/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class SummaryTableViewCell: UITableViewCell {

    @IBOutlet weak var shadowView: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var domainAlphaView: UIView!
    @IBOutlet weak var domainLabel: UILabel!
    @IBOutlet weak var domainNameLabel: UILabel!
    @IBOutlet weak var totalNumberLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    @IBOutlet weak var goodRatingLabel: UILabel!
    @IBOutlet weak var averageRatingLabel: UILabel!
    @IBOutlet weak var badRatingLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        shadowView.layer.cornerRadius = 5
        shadowView.layer.shadowOpacity = 0.24
        shadowView.layer.shadowOffset = CGSize(width: 0, height: 0)
        shadowView.layer.shadowColor = UIColor.black.cgColor
        containerView.layer.cornerRadius = 15
        containerView.clipsToBounds = true
        domainAlphaView.clipsToBounds = true
        domainAlphaView.layer.cornerRadius = domainAlphaView.frame.size.height/2
    }
}
