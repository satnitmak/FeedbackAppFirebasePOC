//
//  SwitchTableViewCell.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/13/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class SwitchTableViewCell: UITableViewCell {
    
    @IBOutlet weak var actionSwitch: UISwitch!
    @IBOutlet weak var button: UIButton!
    
    weak var vc: ViewController?
    
    @IBAction func switchAction(_ sender: UISwitch) {
        vc?.switchAction(isAll: sender.isOn)
    }
    @IBAction func clickAction(_ sender: UIButton) {
        var text = sender.titleLabel?.text ?? ""
        switch text {
        case Domain.lc.rawValue:
            text = Domain.guarentees.rawValue
        case Domain.guarentees.rawValue:
            text = Domain.collection.rawValue
        case Domain.collection.rawValue:
            text = Domain.utilization.rawValue
        case Domain.utilization.rawValue:
            text = Domain.lc.rawValue
        default:
            text = Domain.lc.rawValue
        }
        button.setTitle(text, for: .normal)
        vc?.domainSelected(domain: Domain(rawValue: text))
    }
    
    
}
