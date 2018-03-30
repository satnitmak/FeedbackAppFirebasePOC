//
//  AdminViewModel.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/9/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class SummaryViewModel: NSObject {
    
    var ratings = [Rating]()
    let red = UIColor(red: 226/255, green: 64/255, blue: 98/255, alpha: 1)
    let orange = UIColor(red: 233/255, green: 144/255, blue: 75/255, alpha: 1)
    let green = UIColor(red: 85/255, green: 210/255, blue: 165/255, alpha: 1)
    
    func updateModel(dictArray: [[String: Any]]) {
        ratings = [Rating]()
        for dict in dictArray {
            if let regionStr = dict["r"] as? String,
                let countryStr = dict["c"] as? String {
                let r1 = dict["r1"] as? Int
                let r2 = dict["r2"] as? Int
                let r3 = dict["r3"] as? Int
                let r4 = dict["r4"] as? Int
                let question = dict["q"] as? String
                let region = Region(rawValue: regionStr)
                let country = Country(rawValue: countryStr)
                let rating = Rating(region: region, country: country, question: question, domain: [(.lc, r1), (.guarentees, r2), (.collection, r3), (.utilization, r4)])
                ratings.append(rating)
            }
        }
    }
    
    func getRatingObjects(regions: [Region], countries: [Country]) -> [Rating] {
        let filteredRatings = ratings.filter { (rating) -> Bool in
            guard let country = rating.country,
                let region = rating.region else {return false}
            let isRegion = (regions.count > 0) ? (regions.contains(region)) : true
            let isCountry = (countries.count > 0) ? (countries.contains(country)) : true
            return isRegion && isCountry
        }
        return filteredRatings
    }
    
    func getReport(ratings: [Rating], index: Int) -> (good: Int, average: Int, bad: Int, color: UIColor) {
        var good = 0
        var average = 0
        var bad = 0
        for rating in ratings {
            if let domainArray = rating.domain,
                domainArray.count > 0, let rating = domainArray[index].1 {
                switch rating {
                case 1 ..< 5 :
                    bad += 1
                case 5 ..< 8 :
                    average += 1
                case 8 ..< 11 :
                    good += 1
                default:
                    print("nothing here")
                }
            }
        }
        let count: Float = Float(good + average + bad)
        let color: UIColor = (Float(good)/count >= 0.8) ? green :
        (Float(good)/count >= 0.5) ? orange : red
        return (good, average, bad, color)
    }
    
    func fetchData(completionHandler: @escaping () -> () ) {
        ratings = [Rating]()
        DataManager.fetchRatings { (dictArray) in
            self.updateModel(dictArray: dictArray)
            completionHandler()
        }
    }
    
    func getDomainStr(index: Int) -> String {
        switch index {
        case 0:
            return "LC"
        case 1:
            return "G"
        case 2:
            return "C"
        case 3:
            return "U"
        default:
            return "NA"
        }
    }
    
    func getDomainName(index: Int) -> String {
        switch index {
        case 0:
            return Domain.lc.rawValue
        case 1:
            return Domain.guarentees.rawValue
        case 2:
            return Domain.collection.rawValue
        case 3:
            return Domain.utilization.rawValue
        default:
            return "NA"
        }
    }
    @IBAction func doneButtonClicked(_ sender: UIButton) {
    }
}
