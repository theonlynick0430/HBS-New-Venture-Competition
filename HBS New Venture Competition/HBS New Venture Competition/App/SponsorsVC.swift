//
//  SponsorsVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import SVProgressHUD
import ESPullToRefresh
import Firebase

class SponsorsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //data source
    private var sponsors = [Sponsor]() { didSet{ tableView.reloadData() } }
    
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
        
        //setup
        setupRefresh()
        fetchSponsors()
    }
    
    // MARK: - Essential Functions
    
    private func fetchSponsors(){
        
        SVProgressHUD.show()
        
        FirebaseManager.manager.fetchSponsors { (sponsors, error) in
            SVProgressHUD.dismiss()
            guard let sponsors = sponsors, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.sponsors = sponsors
            self.sponsors.sort(by: { $0.name < $1.name })
        }
    }
    
    // MARK: - Helper Functions
    
    private func setupRefresh(){
        tableView.es.addPullToRefresh {
            self.tableView.es.stopPullToRefresh()
            self.fetchSponsors()
        }
    }
    
    // MARK: - Tableview Delegate and Datasource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if UIDevice.current.deviceIsiPad{
            return 225
        }
        return 275
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return sponsors.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if UIDevice.current.deviceIsiPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: SponsorLargeCell.identifier, for: indexPath)
            if let cell = cell as? SponsorLargeCell{
                cell.sponsor = sponsors[indexPath.row]
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: SponsorCell.identifier, for: indexPath)
            if let cell = cell as? SponsorCell{
                cell.sponsor = sponsors[indexPath.row]
            }
            return cell
        }
    }

}
