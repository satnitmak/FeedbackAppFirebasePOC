//
//  DataManager.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/8/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit
import Firebase
import FirebaseDatabase

class DataManager: NSObject {
    
    fileprivate static let ratings: String = "ratings"
    fileprivate static let rootRef = Database.database().reference()

    static func submit(dict: [String: Any]) {
        rootRef.child(ratings).childByAutoId().setValue(dict)
    }
    
    static func fetchRatings(completionHandler: @escaping (_ dict: [[String: Any]]) -> () ) {
        rootRef.observeSingleEvent(of: .value) { (snapshot) in
            guard let response = snapshot.value as? [String: Any],
                let dictArray = response[ratings] as? [String: Any] else {return}
            var dict = [[String: Any]]()
            for key in Array(dictArray.keys){
                if let dictObj = dictArray[key] as? [String: Any] {
                    dict.append(dictObj)
                }
            }
            completionHandler(dict)
        }
        
        rootRef.observe(.childChanged, with: { (snapshot) in
            guard let dictArray = snapshot.value as? [String: Any] else {return}
            var dict = [[String: Any]]()
            for key in Array(dictArray.keys){
                if let dictObj = dictArray[key] as? [String: Any] {
                    dict.append(dictObj)
                }
            }
            completionHandler(dict)
        })
    }

}
