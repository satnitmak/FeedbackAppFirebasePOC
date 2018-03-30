//
//  RatingTableViewCell.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/8/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class RatingTableViewCell: UITableViewCell {

    var domain: Domain?
    var rating: Int? {
        didSet {
            updateRating()
        }
    }
    weak var vc: ViewController?

    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var questionLabel: UILabel!
    @IBOutlet weak var stackView: UIStackView!
    
    @IBOutlet weak var r1Button: UIButton!
    @IBOutlet weak var r2Button: UIButton!
    @IBOutlet weak var r3Button: UIButton!
    @IBOutlet weak var r4Button: UIButton!
    @IBOutlet weak var r5Button: UIButton!
    @IBOutlet weak var r6Button: UIButton!
    @IBOutlet weak var r7Button: UIButton!
    @IBOutlet weak var r8Button: UIButton!
    @IBOutlet weak var r9Button: UIButton!
    @IBOutlet weak var r10Button: UIButton!
    
    let redColor = UIColor(red: 210/255, green: 74/255, blue: 74/255, alpha: 1)
    let orangeColor = UIColor.orange
    let greenColor = UIColor(red: 46/255, green: 185/255, blue: 60/255, alpha: 1)
    
    @IBAction func r1ButtonClicked(_ sender: UIButton) {
        rating = 1
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }

    @IBAction func r2ButtonClicked(_ sender: UIButton) {
        rating = 2
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }
    
    @IBAction func r3ButtonClicked(_ sender: UIButton) {
        rating = 3
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }

    @IBAction func r4ButtonClicked(_ sender: UIButton) {
        rating = 4
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }
    
    @IBAction func r5ButtonClicked(_ sender: UIButton) {
        rating = 5
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }
    
    @IBAction func r6ButtonClicked(_ sender: UIButton) {
        rating = 6
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }
    @IBAction func r7ButtonClicked(_ sender: UIButton) {
        rating = 7
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }
    @IBAction func r8ButtonClicked(_ sender: UIButton) {
        rating = 8
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }
    @IBAction func r9ButtonClicked(_ sender: UIButton) {
        rating = 9
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }
    @IBAction func r10ButtonClicked(_ sender: UIButton) {
        rating = 10
        guard let domain = domain, let rating = rating else { return }
        rating > 0 ? vc?.ratingsUpdated(domain: domain, rating: rating) : ()
    }

    override func awakeFromNib() {
        super.awakeFromNib()
        r1Button.imageView?.contentMode = .scaleAspectFit
        r2Button.imageView?.contentMode = .scaleAspectFit
        r3Button.imageView?.contentMode = .scaleAspectFit
        r4Button.imageView?.contentMode = .scaleAspectFit
        r5Button.imageView?.contentMode = .scaleAspectFit
        r6Button.imageView?.contentMode = .scaleAspectFit
        r7Button.imageView?.contentMode = .scaleAspectFit
        r8Button.imageView?.contentMode = .scaleAspectFit
        r9Button.imageView?.contentMode = .scaleAspectFit
        r10Button.imageView?.contentMode = .scaleAspectFit

        r1Button.alpha = 0.3
        r2Button.alpha = 0.3
        r3Button.alpha = 0.3
        r4Button.alpha = 0.3
        r5Button.alpha = 0.3
        r6Button.alpha = 0.3
        r7Button.alpha = 0.3
        r8Button.alpha = 0.3
        r9Button.alpha = 0.3
        r10Button.alpha = 0.3
    }

    func setRating(rating: Int) {
        self.rating = rating
    }
    
    func updateRating() {
        guard let lRating = rating else {
            rating = 0
            return
        }
        r1Button.alpha = (lRating >= 1) ? 1 : 0.3
        r2Button.alpha = (lRating >= 2) ? 1 : 0.3
        r3Button.alpha = (lRating >= 3) ? 1 : 0.3
        r4Button.alpha = (lRating >= 4) ? 1 : 0.3
        r5Button.alpha = (lRating >= 5) ? 1 : 0.3
        r6Button.alpha = (lRating >= 6) ? 1 : 0.3
        r7Button.alpha = (lRating >= 7) ? 1 : 0.3
        r8Button.alpha = (lRating >= 8) ? 1 : 0.3
        r9Button.alpha = (lRating >= 9) ? 1 : 0.3
        r10Button.alpha = (lRating >= 10) ? 1 : 0.3
        ratingLabel.text = lRating.description + "/10"
        ratingLabel.textColor = getColor()
    }
    
    func getColor() -> UIColor {
        guard let lRating = rating, lRating != 0 else {
            return .clear
        }
        
        if lRating > 7 {
            return greenColor
        } else if lRating >= 5 {
            return orangeColor
        } else {
            return redColor
        }
    }
}
