//
//  RefViewController.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/8/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class RefViewController: UIViewController {
    
    var regionRef: Region?
    var countryRef: Country?
    var showRegion = true
    weak var vc: ViewController?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        title = "Select " + (showRegion ? "Region" : "Country")
    }
    
}
extension RefViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if showRegion {
            return Region.getRegions().count
        } else {
            guard let region = regionRef else { return 0 }
            return region.getCountries().count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "refCell", for: indexPath)
        
        if showRegion, Region.getRegions().count > indexPath.row {
            let region = Region.getRegions()[indexPath.row]
            cell.textLabel?.text = region.rawValue
            (regionRef == region) ? (cell.accessoryType = .checkmark ): (cell.accessoryType = .none)
        } else if let region = regionRef, region.getCountries().count > indexPath.row {
            let country = region.getCountries()[indexPath.row]
            cell.textLabel?.text = country.rawValue
            (countryRef == country) ? (cell.accessoryType = .checkmark ): (cell.accessoryType = .none)
        } else {
            cell.textLabel?.text = "NA"
            cell.accessoryType = .none
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
extension RefViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if showRegion, Region.getRegions().count > indexPath.row {
            let region = Region.getRegions()[indexPath.row]
            regionRef = region
        } else if let region = regionRef, region.getCountries().count > indexPath.row {
            let country = region.getCountries()[indexPath.row]
            countryRef = country
        }
//        tableView.reloadData()
        vc?.refSelected(isRegionRef: showRegion, regionRef: regionRef, countryRef: countryRef)
    }
    
}
