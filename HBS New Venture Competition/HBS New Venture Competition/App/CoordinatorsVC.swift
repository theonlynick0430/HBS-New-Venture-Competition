//
//  CoordinatorsVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

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
    }
    
    // MARK: - Essential Functions
    
    private func fetchCoordinators(){
        FirebaseManager.manager.fetchCoordinators { (coordinators, error) in
            guard let coordinators = coordinators, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.coordinators = coordinators
        }
    }
    
    // MARK: - Tableview Delegate and Datasource
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CoordinatorCell.identifier, for: indexPath)
        if let cell = cell as? CoordinatorCell{
            cell.coordinator = coordinators[indexPath.row]
        }
        return cell
    }

}
