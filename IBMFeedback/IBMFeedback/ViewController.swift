//
//  ViewController.swift
//  IBMFeedback
//
//  Created by Sathyanarayanan V on 2/8/18.
//  Copyright © 2018 Sathyanarayanan V. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    
    var isAll = true
    var domain: Domain?
    
    let viewModel = ViewModel()
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var submitButton: UIButton!
    
    static var isAdmin = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillShow), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(ViewController.keyboardWillHide), name: NSNotification.Name.UIKeyboardWillHide, object: nil)
        setupView()
        if !ViewController.isAdmin {
            navigationController?.tabBarController?.viewControllers?.remove(at: 1)
        }
    }
    
    func setupView() {
        tableView.backgroundColor = UIColor(red: 235/255, green: 235/255, blue: 241/255, alpha: 1)
        tableView.dataSource = self
        tableView.delegate = self
        tableView.tableFooterView = UIView()
        submitButton.alpha = 0.3
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.clear], for: .selected)
        UITabBarItem.appearance().setTitleTextAttributes([NSAttributedStringKey.foregroundColor:UIColor.clear], for: .normal)
    }
    
    @objc func keyboardWillShow(_ notification:Notification) {
        if let keyboardSize = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset.bottom = keyboardSize.height
            tableView.scrollToRow(at: IndexPath.init(row: 0, section: 2), at: .top, animated: true)
        }
    }
    
    @objc func keyboardWillHide(_ notification:Notification) {
        if let _ = (notification.userInfo?[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
            tableView.contentInset.bottom = 0
        }
    }
    
    @IBAction func submitButtonClicked(_ sender: UIButton) {
        let tuple = viewModel.isDataComplete()
        guard tuple.0, let dict = viewModel.getRatingsDict() else {
            if let text = tuple.1 {
                showToast(text: text)
            }
            return
        }
        DataManager.submit(dict: dict)
        submitButton.alpha = 0.3
        viewModel.reset()
        tableView.reloadData()
        showToast(text: "Feedback Submitted")
    }
    
    func updateSubmitButtonStatus() {
        let tuple = viewModel.isDataComplete()
        guard tuple.0 else {
            submitButton.alpha = 0.3
            return
        }
        submitButton.alpha = 1
    }
    
    func refSelected(isRegionRef: Bool, regionRef: Region?, countryRef: Country?) {
        if isRegionRef, let region = regionRef {
            (viewModel.regionSelected() != region) ? viewModel.updateCountry(country: nil) : ()
            viewModel.updateRegion(region: region)
        } else if let country = countryRef {
            viewModel.updateCountry(country: country)
        }
        navigationController?.popViewController(animated: true)
        tableView.reloadData()
        updateSubmitButtonStatus()
    }
    
    func ratingsUpdated(domain: Domain, rating: Int) {
        viewModel.updateDomain(domain: (domain, rating))
        tableView.reloadData()
        updateSubmitButtonStatus()
    }
    
    func switchAction(isAll: Bool) {
        self.isAll = isAll
        isAll ? (domain = nil) : ()
        viewModel.resetDomain()
        tableView.reloadData()
    }
    
    func domainSelected(domain: Domain?) {
        self.domain = domain
        viewModel.resetDomain()
        tableView.reloadData()
    }
    
    func questionAnswered(string: String) {
        viewModel.updateQuestion(question: string)
        tableView.reloadData()
        updateSubmitButtonStatus()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        title = "Feedback"
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        title = ""
    }
    
    func showToast(text: String) {
        let label = UILabel()
        label.text = text
        label.textColor = .white
        label.font = UIFont.boldSystemFont(ofSize: 15)
        label.sizeToFit()
        
        let view = UIView()
        view.frame.size.height = label.frame.size.height + 16
        view.frame.size.width = label.frame.size.width + 16
        view.clipsToBounds = true
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = view.frame.size.height / 2
        label.center.x = view.center.x
        label.center.y = view.center.y
        view.addSubview(label)
        view.center.x = self.view.center.x
        view.frame.origin.y = self.view.frame.size.height
        self.view.addSubview(view)
        
        UIView.animate(withDuration: 0.3, animations: {
            view.frame.origin.y = view.frame.origin.y - 95
        }) { (complete) in
            UIView.animate(withDuration: 0.3, delay: 1, options: [], animations: {
                view.alpha = 0
            }, completion: { (completed) in
                if completed {
                    view.removeFromSuperview()
                }
            })
        }
    }
}

extension ViewController: UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 3
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section {
        case 0:
            return 2
        case 1 :
            return isAll ? 4 : 1
        case 2:
            return 1
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell: UITableViewCell
        switch indexPath.section {
        case 0:
            cell = tableView.dequeueReusableCell(withIdentifier: "refCell", for: indexPath)
            
            guard let lCell = cell as? RefTableViewCell else {return cell}
            lCell.vc = self
            lCell.labelImageView.image = (indexPath.row == 0) ? viewModel.getRegionImage() : viewModel.getCountryImage()
            lCell.titleLabel.text = (indexPath.row == 0) ? viewModel.getRegionText() : viewModel.getCountryText()
            lCell.valueLabel.text = (indexPath.row == 0) ?
                viewModel.regionSelected()?.rawValue ?? "Select"
                : viewModel.countrySelected()?.rawValue ?? "Select"
            
        case 1 :
            cell = tableView.dequeueReusableCell(withIdentifier: "ratingCell", for: indexPath)
            
            guard let lCell = cell as? RatingTableViewCell else {return cell}
            lCell.vc = self
            var domain: (Domain, Int?)?
            if isAll {
                domain = viewModel.domainSelected(index: indexPath.row)
                lCell.questionLabel.text = viewModel.getDomainText(index: indexPath.row)
            } else if let lDomain = self.domain {
                domain = (lDomain, viewModel.ratingSelected(domain: lDomain))
                lCell.questionLabel.text = viewModel.getDomainText(domain: lDomain)
            }
            lCell.domain = domain?.0
            lCell.rating = domain?.1 ?? 0
            
        case 2:
            cell = tableView.dequeueReusableCell(withIdentifier: "questionCell", for: indexPath)
            
            guard let lCell = cell as? QuestionTableViewCell else {return cell}
            lCell.vc = self
            if let ques = viewModel.questionSelected() {
                lCell.textView.text = ques
            } else {
                lCell.textView.text = ""
            }
            
        default:
            cell = UITableViewCell()
        }
        cell.selectionStyle = .none
        cell.backgroundColor = (indexPath.row % 2 == 0) ? .white : UIColor(white: 0.985, alpha: 1)
        return cell
    }
}

extension ViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("click")
        if indexPath.section == 0,
            let vc = storyboard?.instantiateViewController(withIdentifier: "RefViewController") as? RefViewController {
            if indexPath.row == 0 {
                vc.showRegion = true
                vc.regionRef = viewModel.regionSelected()
            } else {
                vc.showRegion = false
                vc.regionRef = viewModel.regionSelected()
                vc.countryRef = viewModel.countrySelected()
            }
            vc.vc = self
            navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        switch indexPath.section {
        case 0:
            return 45
        case 1 :
            return 110
        case 2:
            return 130
        default:
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard section == 1 else { return nil }
        let cell = tableView.dequeueReusableCell(withIdentifier: "switchCell") as? SwitchTableViewCell
        cell?.actionSwitch.setOn(isAll, animated: false)
        
        if !isAll {
            if let domain = self.domain {
                cell?.button.setTitle(domain.rawValue, for: .normal)
            }else {
                cell?.button.setTitle(Domain.lc.rawValue, for: .normal)
            }
        }
        else {
            cell?.button.setTitle("", for: .normal)
        }
        cell?.vc = self
        return cell
    }
}
