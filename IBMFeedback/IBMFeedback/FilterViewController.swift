//
//  FilterViewController.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/8/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    var regionRef: Region?
    var countryRef: Country?
    
    weak var vc: SummaryViewController?
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        title = "Select Filter"
    }
    @IBAction func doneButtonClicked(_ sender: UIButton) {
        navigationController?.popViewController(animated: true)
    }
    
}
extension FilterViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == 0 {
            return 4
        } else {
            guard let region = regionRef else { return 0 }
            return region.getCountries().count + 1
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "refCell", for: indexPath)
        
        if indexPath.section == 0, Region.getRegions().count > indexPath.row {
            let region = Region.getRegions()[indexPath.row]
            cell.textLabel?.text = region.rawValue
            (regionRef == region) ? (cell.accessoryType = .checkmark ): (cell.accessoryType = .none)
        } else if indexPath.section == 1, let region = regionRef, region.getCountries().count > indexPath.row {
            let country = region.getCountries()[indexPath.row]
            cell.textLabel?.text = country.rawValue
            (countryRef == country) ? (cell.accessoryType = .checkmark ): (cell.accessoryType = .none)
        } else {
            cell.textLabel?.text = "All"
            if indexPath.section == 0, regionRef == nil {
                cell.accessoryType = .checkmark
            } else if indexPath.section == 1, countryRef == nil {
                cell.accessoryType = .checkmark
            } else {
                cell.accessoryType = .none
            }
        }
        cell.selectionStyle = .none
        return cell
    }
    
}
extension FilterViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == 0, Region.getRegions().count > indexPath.row {
            let region = Region.getRegions()[indexPath.row]
            (regionRef != nil && regionRef != region) ? (countryRef = nil) : ()
            regionRef = region
        } else if indexPath.section == 1, let region = regionRef, region.getCountries().count > indexPath.row {
            let country = region.getCountries()[indexPath.row]
            countryRef = country
        } else if indexPath.section == 0 {
            regionRef = nil
            countryRef = nil
        } else {
            countryRef = nil
        }
        vc?.updateFilter(region: regionRef, country: countryRef)
        tableView.reloadData()
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

