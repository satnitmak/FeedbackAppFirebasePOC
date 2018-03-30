//
//  SummaryViewController.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/9/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class SummaryViewController: UIViewController {
    
    @IBOutlet weak var tableView: UITableView!
    
    let viewModel = SummaryViewModel()
    var tempRatings = [Rating]()
    var region: Region?
    var country: Country?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchData()
        tableView.tableFooterView = UIView()
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(barButtonSystemItem: UIBarButtonSystemItem.add, target: self, action: #selector(onButtonTap))
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.clear], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.clear], for: .normal)
    }
    
    @objc func onButtonTap() {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "FilterViewController") as? FilterViewController {
            vc.regionRef = region
            vc.countryRef = country
            vc.vc = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Summary"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    func fetchData() {
        viewModel.fetchData {
            DispatchQueue.main.async {
                self.tableView.dataSource = self
                self.tableView.delegate = self
                self.tableView.separatorColor = .clear
                self.refreshView()
            }
        }
    }
    
    func updateFilter(region: Region?, country: Country?) {
        self.region = region
        self.country = country
        refreshView()
    }
    
    func refreshView() {
        var regionArr: [Region] = []
        if let regionRef = region {
            regionArr.append(regionRef)
        }
        var countryArr: [Country] = []
        if let countryRef = country {
            countryArr.append(countryRef)
        }
        self.tempRatings = self.viewModel.getRatingObjects(regions: regionArr, countries: countryArr)
        self.tableView.reloadData()
    }
    
}

extension SummaryViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 4
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "summaryCell", for: indexPath)
        let lCell = cell as? SummaryTableViewCell
        let tuple = viewModel.getReport(ratings: tempRatings, index: indexPath.row)
        
        lCell?.domainLabel.text = viewModel.getDomainStr(index: indexPath.row)
        lCell?.domainNameLabel.text = viewModel.getDomainName(index: indexPath.row)
        lCell?.goodRatingLabel.text = tuple.good.description
        lCell?.averageRatingLabel.text = tuple.average.description
        lCell?.badRatingLabel.text = tuple.bad.description
        lCell?.totalNumberLabel.text = (tuple.good + tuple.average + tuple.bad).description
        lCell?.containerView.backgroundColor = tuple.color
        cell.selectionStyle = .none

        return cell
    }
}

extension SummaryViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 145
    }
}
