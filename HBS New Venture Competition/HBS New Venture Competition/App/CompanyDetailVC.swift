//
//  CompanyDetailVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/22/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import Cosmos

class CompanyDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var logoImageView: AsyncImageView!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var tableView: UITableView!
    
    //data source
    var company: Company!
    private var companyMembers = [CompanyMember]() { didSet{ tableView.reloadData() } }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.allowsSelection = false
        let px = 1 / UIScreen.main.scale
        let frame = CGRect(x: 0, y: 0, width: tableView.frame.size.width, height: px)
        let line = UIView(frame: frame)
        line.backgroundColor = tableView.separatorColor
        tableView.tableHeaderView = line
        tableView.tableFooterView = UIView(frame: CGRect.zero)
    }
    
    // MARK: - Essential Functions
    
    private func fetchCompanyMembers(){
        FirebaseManager.manager.fetchCompanyMembers(companyID: company.companyID) { (companyMembers, error) in
            guard let companyMembers = companyMembers, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.companyMembers = companyMembers
        }
    }
    
    // MARK: - Tableview Delegate and Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CompanyMemberCell.identifier, for: indexPath)
        if let cell = cell as? CompanyMemberCell{
            cell.companyMember = companyMembers[indexPath.row]
        }
        return cell
    }

}
