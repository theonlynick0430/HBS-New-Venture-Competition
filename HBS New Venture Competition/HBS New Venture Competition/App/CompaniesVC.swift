//
//  CompaniesVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import PopupDialog
import SVProgressHUD
import ESPullToRefresh

class CompaniesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate, UICollectionViewDelegateFlowLayout {
    
    //outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var searchBtn: UIButton!
    @IBOutlet weak var voteBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //data source
    private var companies = [Company]() { didSet{ collectionView.reloadData() } }
    private var filteredCompanies = [Company]() { didSet{ collectionView.reloadData() } }
    
    private var selectedCompany: Company!
    
    private var searchInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        //limits to only vertical scroll
        collectionView.alwaysBounceVertical = true
        let layout = collectionView.collectionViewLayout as! UICollectionViewFlowLayout
        layout.scrollDirection = .vertical
        if let flowLayout = collectionView.collectionViewLayout as? UICollectionViewFlowLayout{
            flowLayout.estimatedItemSize = CGSize(width: view.frame.width-20, height: 125)
            flowLayout.itemSize = UICollectionViewFlowLayoutAutomaticSize
        }
        
        //rounds corners
        voteBtn.layer.masksToBounds = true
        voteBtn.layer.cornerRadius = 5
        searchBtn.layer.masksToBounds = true
        searchBtn.layer.cornerRadius = 5
        
        voteBtn.addTarget(self, action: #selector(CompaniesVC.voteBtnPressed(_:)), for: .touchUpInside)
        searchBtn.addTarget(self, action: #selector(CompaniesVC.searchBtnPressed(_:)), for: .touchUpInside)
        
        //setup
        setupSearchBar()
        setupRefresh()
        fetchCompanies()
    }
    
    // MARK: - Essential Functions
    
    private func fetchCompanies(){
        
        SVProgressHUD.show()
        
        FirebaseManager.manager.fetchCompanies { (companies, error) in
            SVProgressHUD.dismiss()
            guard let companies = companies, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.companies = companies
            self.companies.sort(by: { $0.order < $1.order })
        }
    }
    
    // MARK: - Helper Functions
    
    private func setupRefresh(){
        collectionView.es.addPullToRefresh {
            self.collectionView.es.stopPullToRefresh()
            self.fetchCompanies()
        }
    }
    
    @objc private func voteBtnPressed(_ sender: UIButton){
        if let _ = AppStorage.eventCode{
            let popup = PopupDialog(title: "You're set", message: "Voting has already been enabled on this device", image: nil, buttonAlignment: .horizontal, transitionStyle: .bounceDown, preferredWidth: self.view.frame.width - 100, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
            popup.addButton(CancelButton(title: "OK", height: 60, dismissOnTap: true, action: nil))
            self.present(popup, animated: true, completion: nil)
        }else{
            let eventCodeVC = EventCodeVC(nibName: "EventCodeVC", bundle: Bundle.main)
            let popup = PopupDialog(viewController: eventCodeVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, preferredWidth: self.view.frame.width-100, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
            popup.addButton(CancelButton(title: "CANCEL", height: 60, dismissOnTap: true, action: nil))
            eventCodeVC.executionBlock = { eventCode in
                AppStorage.eventCode = eventCode
                AppStorage.save()
                popup.dismiss()
            }
            self.present(popup, animated: true, completion: nil)
        }
    }
    
    @objc private func searchBtnPressed(_ sender: UIButton){
        let countVC = CountVC(nibName: "CountVC", bundle: Bundle.main)
        var numbers = [Int]()
        if searchInProgress{
            filteredCompanies.forEach { (company) in
                numbers.append(company.order)
            }
        }else{
            companies.forEach { (company) in
                numbers.append(company.order)
            }
        }
        
        countVC.numbers = numbers
        let popup = PopupDialog(viewController: countVC, buttonAlignment: .horizontal, transitionStyle: .bounceDown, preferredWidth: self.view.frame.width-100, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
        popup.addButton(CancelButton(title: "CANCEL", height: 60, dismissOnTap: true, action: nil))
        popup.addButton(DefaultButton(title: "DONE", height: 60, dismissOnTap: true, action: {
            if self.searchInProgress{
                for (index, value) in self.filteredCompanies.enumerated(){
                    if value.order == countVC.selectedNumber{
                        self.collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
                            self.collectionView.delegate?.collectionView!(self.collectionView, didSelectItemAt: IndexPath(row: index, section: 0))
                    }
                }
            }else{
                for (index, value) in self.companies.enumerated(){
                    if value.order == countVC.selectedNumber{
                        self.collectionView.selectItem(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
                        self.collectionView.delegate?.collectionView!(self.collectionView, didSelectItemAt: IndexPath(row: index, section: 0))
                    }
                }
            }
        }))
        self.present(popup, animated: true, completion: nil)
    }
    
    private func setupSearchBar(){
        searchBar.change(textFont: UIFont(name: "Avenir", size: 14))
        searchBar.placeholder = "Search companies"
    }
    
    // MARK: - Collection View Delegate and Datasource
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if searchInProgress{
            return filteredCompanies.count
        }
        return companies.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.identifier, for: indexPath)
        if let cell = cell as? CompanyCell{
            if searchInProgress{
                cell.company = filteredCompanies[indexPath.row]
            }else{
                cell.company = companies[indexPath.row]
            }
        }
        
        //rounds corners
        cell.layer.masksToBounds = true
        cell.layer.cornerRadius = 10
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if searchInProgress{
            selectedCompany = filteredCompanies[indexPath.row]
        }else{
            selectedCompany = companies[indexPath.row]
        }
        performSegue(withIdentifier: NameFile.Segues.toCompanyDetail, sender: self)
    }
    
    // MARK: - Search Bar Delegate
    
    func searchBarTextDidBeginEditing(_ searchBar: UISearchBar) {
        searchInProgress = true
        filteredCompanies = companies
        searchBar.showsCancelButton = true
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searchInProgress = false
        searchBar.resignFirstResponder()
        searchBar.text = nil
        searchBar.showsCancelButton = false
        collectionView.reloadData()
    }
    
    private var fetchInProgress = false
    
    //updates the results collectionview when the search text changes
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        searchInProgress = true
        
        filteredCompanies = companies.filter({ (company) -> Bool in
            let name = company.name
            if name.lowercased().contains(searchText.lowercased()) {
                return true
            }
            if searchText == ""{
                return true
            }
            return false
        })
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToCompanies(segue: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let companyDetailVC = segue.destination as? CompanyDetailVC{
            companyDetailVC.company = selectedCompany
        }
    }
    
}
