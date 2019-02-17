//
//  CoordinatorsVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import SVProgressHUD
import ESPullToRefresh

class CoordinatorsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //data source
    private var coordinators = [Coordinator]() { didSet{ tableView.reloadData() } }
    
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
        fetchCoordinators()
    }
    
    // MARK: - Essential Functions
    
    private func fetchCoordinators(){
        
        SVProgressHUD.show()
        
        FirebaseManager.manager.fetchCoordinators { (coordinators, error) in
            SVProgressHUD.dismiss()
            guard let coordinators = coordinators, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.coordinators = coordinators
            self.coordinators.sort(by: { $0.order < $1.order })
        }
    }
    
    // MARK: - Helper Functions
    
    private func setupRefresh(){
        tableView.es.addPullToRefresh {
            self.tableView.es.stopPullToRefresh()
            self.fetchCoordinators()
        }
    }
    
    // MARK: - Tableview Delegate and Datasource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 110
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return coordinators.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoordinatorCell.identifier, for: indexPath)
        if let cell = cell as? CoordinatorCell{
            cell.coordinator = coordinators[indexPath.row]
        }
        return cell
    }

}
