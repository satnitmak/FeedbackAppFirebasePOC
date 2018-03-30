//
//  RatingObjects.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/8/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import Foundation

struct Rating {
    var region: Region?
    var country: Country?
    var question: String?
    var domain: [(Domain, Int?)]?
}


enum Region: String {
    case retail = "Retail"
    case cibEMEA = "CIB EMEA"
    case cibAPAC = "CIB APAC"
    
    func getCountries() -> [Country] {
        switch self {
        case .retail:
            return [.frb, .fortis]
        case .cibEMEA:
            return [.netherlands, .uk, .spain, .thailand, .germany, .dubai, .qatar, .abuDhabi, .kuwait, .bahrain]
        case .cibAPAC:
            return [.india, .singapore, .vietnam, .china, .southKorea, .japan, .taiwan, .australia]
        }
    }
    
    static func getRegions() -> [Region] {
        return [.retail, .cibEMEA, .cibAPAC]
    }
}

enum Country: String {
    case frb = "France"
    case fortis = "Belgium"
    case india = "India"
    case singapore = "Singapore"
    case vietnam = "Vietnam"
    case china = "China"
    case southKorea = "South Korea"
    case japan = "Japan"
    case taiwan = "Taiwan"
    case australia = "Australia"
    case netherlands = "Netherlands"
    case uk = "United Kingdom"
    case spain = "Spain"
    case thailand = "Thailand"
    case germany = "Germany"
    case dubai = "Dubai"
    case qatar = "Qatar"
    case abuDhabi = "Abu Dhabi"
    case kuwait = "Kuwait"
    case bahrain = "Bahrain"
}

enum Domain: String {
    case lc = "Letter of Credit"
    case guarentees = "Guarentees"
    case collection = "Collection"
    case utilization = "Utilization"
}
