//
//  JudgesVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import SVProgressHUD
import ESPullToRefresh

class JudgesVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    //data source
    private var judges = [Judge]() { didSet{ tableView.reloadData() } }
    
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
        tableView.estimatedRowHeight = 100
        tableView.rowHeight = UITableViewAutomaticDimension
        
        //setup
        setupRefresh()
        fetchJudges()
    }
    
    // MARK: - Essential Functions
    
    private func fetchJudges(){
        
        SVProgressHUD.show()
        
        FirebaseManager.manager.fetchJudges { (judges, error) in
            SVProgressHUD.dismiss()
            guard let judges = judges, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.judges = judges
            self.judges.sort(by: { $0.order < $1.order })
        }
    }
    
    // MARK: - Helper Functions
    
    private func setupRefresh(){
        tableView.es.addPullToRefresh {
            self.tableView.es.stopPullToRefresh()
            self.fetchJudges()
        }
    }
    
    // MARK: - Tableview Delegate and Datasource

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return judges.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: JudgeCell.identifier, for: indexPath)
        if let cell = cell as? JudgeCell{
            cell.judge = judges[indexPath.row]
        }
        return cell
    }

}
