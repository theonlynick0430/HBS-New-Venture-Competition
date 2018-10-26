//
//  CompaniesVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import PopupDialog

class CompaniesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource, UISearchBarDelegate {
    
    //outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var countBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //data source
    private var companies = [Company]() { didSet{ collectionView.reloadData() } }
    private var filteredCompanies = [Company]() { didSet{ collectionView.reloadData() } }
    
    private var searchInProgress = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        searchBar.delegate = self
        
        //rounds corners
        countBtn.layer.masksToBounds = true
        countBtn.layer.cornerRadius = countBtn.frame.width/2
        
        countBtn.addTarget(self, action: #selector(CompaniesVC.countBtnPressed(_:)), for: .touchUpInside)
        
        //setup
        setupSearchBar()
        fetchCompanies()
    }
    
    // MARK: - Essential Functions
    
    private func fetchCompanies(){
        FirebaseManager.manager.fetchCompanies { (companies, error) in
            guard let companies = companies, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.companies = companies
        }
    }
    
    // MARK: - Helper Functions
    
    @objc private func countBtnPressed(_ sender: UIButton){
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
                        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .top, animated: true)
                    }
                }
            }else{
                for (index, value) in self.companies.enumerated(){
                    if value.order == countVC.selectedNumber{
                        self.collectionView.scrollToItem(at: IndexPath(row: index, section: 0), at: .top, animated: true)
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
    
    // MARK: - Tableview Delegate and Datasource
    
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
                cell.company = companies[indexPath.row]
            }else{
                cell.company = filteredCompanies[indexPath.row]
            }
        }
        return cell
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
    
    //updates the results tabelview when the search text changes
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
    
}
