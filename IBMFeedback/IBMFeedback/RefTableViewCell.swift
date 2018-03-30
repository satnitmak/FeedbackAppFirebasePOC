//
//  RefTableViewCell.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/8/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class RefTableViewCell: UITableViewCell {

    @IBOutlet weak var labelImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var valueLabel: UILabel!
    weak var vc: ViewController?

}
