//
//  ViewModel.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/8/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import Foundation
import UIKit

class ViewModel: NSObject {
    
    fileprivate var rating: Rating?
    
    func resetDomain() {
        rating?.domain = [(.lc, nil), (.guarentees, nil), (.collection, nil), (.utilization, nil)]
    }
    
    func regionSelected() -> Region? {
        guard let rating = self.rating, let region = rating.region else { return nil }
        return region
    }
    
    func countrySelected() -> Country? {
        guard let rating = self.rating, let country = rating.country else { return nil }
        return country
    }
    
    func domainSelected(index: Int) -> (Domain, Int?)? {
        guard let rating = self.rating, let domainArray = rating.domain,
            domainArray.count > index else { return nil }
        return domainArray[index]
    }
    
    func ratingSelected(domain: Domain) -> Int? {
        let tuple = rating?.domain?.filter({ (tuple) -> Bool in
            return tuple.0 == domain
        }) .first
        return tuple?.1
    }
    
    func questionSelected() -> String? {
        guard let rating = self.rating, let question = rating.question else { return nil }
        return question
    }
    
    func updateRegion(region: Region) {
        initializeRating()
        rating?.region = region
    }
    
    func updateCountry(country: Country?) {
        initializeRating()
        rating?.country = country
    }
    
    func updateDomain(domain: (Domain, Int)) {
        initializeRating()
        guard var domainArray = rating?.domain else { return }
        var index = 0
        for domainObj in domainArray {
            if (domainObj.0 == domain.0) { break } else { (index += 1) }
        }
        if index < domainArray.count {
            rating?.domain![index].1 = domain.1
        }
    }
    
    func updateQuestion(question: String) {
        initializeRating()
        rating?.question = question
    }
    
    func initializeRating() {
        if (rating == nil) {
            rating = Rating()
            rating?.domain = [(.lc, nil), (.guarentees, nil), (.collection, nil), (.utilization, nil)]
        }
    }
    
    func reset() {
        rating = Rating()
        rating?.domain = [(.lc, nil), (.guarentees, nil), (.collection, nil), (.utilization, nil)]
    }
    
    func getCountryImage() -> UIImage {
        return #imageLiteral(resourceName: "country")
    }
    
    func getRegionImage() -> UIImage {
        return #imageLiteral(resourceName: "region")
    }
    
    func getQuestionImage() -> UIImage {
        return UIImage()
    }
    
    func getRegionText() -> String {
        return "Select Region"
    }
    
    func getCountryText() -> String {
        return "Select Country"
    }
    
    func getDomainText(index: Int) -> String {
        initializeRating()
        guard var domainArray = rating?.domain, domainArray.count > index else { return "Domain " + (index + 1).description }
        return "How happy are you with the services of\n" + domainArray[index].0.rawValue + " ?"
    }
    
    func getDomainText(domain: Domain) -> String {
        return "How happy are you with the services of\n" + domain.rawValue + " ?"
    }
    
    func isDataComplete() -> (Bool, String?) {
        guard let _ = rating?.region else {
            return (false, "Select Region")
        }
        
        guard let _ = rating?.country else {
            return (false, "Select Country")
        }
        
        guard let domainArr = rating?.domain else {
            return (false, "Provide Ratings")
        }
        
        var ratingCount = 0
        for domain in domainArr {
            if (domain.1 == nil) { ratingCount += 1 }
        }
        if (ratingCount == 4) {
            return (false, "Provide ratings for Domain")
        } else {
            return (true, nil)
        }
    }
    
    func getRatingsDict() -> [String: Any]? {
        guard let region = rating?.region,
            let country = rating?.country,
            let domainArr = rating?.domain else {return nil}
        return [
            "r1"    : domainArr[0].1,
            "r2"    : domainArr[1].1,
            "r3"    : domainArr[2].1,
            "r4"    : domainArr[3].1,
            "r"     : region.rawValue,
            "c"     : country.rawValue,
            "q"     : rating?.question,
            "id"    : UIDevice.current.identifierForVendor?.uuidString
        ]
    }
}
