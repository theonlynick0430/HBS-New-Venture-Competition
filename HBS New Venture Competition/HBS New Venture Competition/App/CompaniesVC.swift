//
//  CompaniesVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class CompaniesVC: UIViewController, UICollectionViewDelegate, UICollectionViewDataSource {
    
    //outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var countBtn: UIButton!
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var collectionView: UICollectionView!
    
    //data source
    private var companies = [Company]() { didSet{ collectionView.reloadData() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        tableView.allowsSelection = false
        let px = 1 / UIScreen.main.scale
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: px)
        let line = UIView(frame: frame)
        line.backgroundColor = tableView.separatorColor
        tableView.tableHeaderView = line
        tableView.tableFooterView = UIView(frame: CGRect.zero)
        
        //rounds corners
        countBtn.layer.masksToBounds = true
        countBtn.layer.cornerRadius = countBtn.frame.width/2
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
    
    // MARK: - Tableview Delegate and Datasource
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CompanyCell.identifier, for: indexPath)
        if let cell = cell as? CompanyCell{
            cell.company = companies[indexPath.row]
        }
        return cell
    }
    
    // MARK: - Navigation
    
    @IBAction func unwindToCompanies(segue: UIStoryboardSegue) {}
    
}
