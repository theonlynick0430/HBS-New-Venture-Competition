//
//  EventsVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import ESPullToRefresh
import SVProgressHUD
import Firebase

class EventsVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var subHeaderLabel: UILabel!
    @IBOutlet weak var arrowBtn: UIButton!
    @IBOutlet weak var tableView: UITableView!
    
    //data source
    private var events = [Event]() { didSet{ tableView.reloadData() } }
    
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
        
        //rounds corners
        arrowBtn.layer.masksToBounds = true
        arrowBtn.layer.cornerRadius = arrowBtn.frame.width/2
        
        arrowBtn.addTarget(self, action: #selector(EventsVC.arrowBtnPressed(_:)), for: .touchUpInside)
        
        //setup
        setupRefresh()
        fetchEvents()
    }
    
    // MARK: - Essential Functions
    
    private func fetchEvents(){
        
        SVProgressHUD.show()
        
        FirebaseManager.manager.fetchEvents { (events, error) in
            SVProgressHUD.dismiss()
            guard let events = events, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.events = events
            self.events.sort(by: { $0.time.dateValue() < $1.time.dateValue() })
        }
    }
    
    // MARK: - Helper Functions
    
    private func setupRefresh(){
        tableView.es.addPullToRefresh {
            self.tableView.es.stopPullToRefresh()
            self.fetchEvents()
        }
    }
    
    @objc private func arrowBtnPressed(_ sender: UIButton){
        print("PLEASE WORK")
        FirebaseManager.manager.fetchCurrentEvent { (currentEventID, error) in
            guard let currentEventID = currentEventID, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            for (index, value) in self.events.enumerated(){
                if value.eventID == currentEventID{
                    print("YESSSS")
                    self.tableView.allowsSelection = true
                    self.tableView.selectRow(at: IndexPath(row: index, section: 0), animated: true, scrollPosition: .top)
                    Timer.scheduledTimer(withTimeInterval: TimeInterval(exactly: 0.5)!, repeats: false, block: { (_) in
                        self.tableView.deselectRow(at: IndexPath(row: index, section: 0), animated: true)
                        self.tableView.allowsSelection = false
                    })
                }
            }
        }
    }
    
    // MARK: - Tableview Delegate and Datasource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 75
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: EventCell.identifier, for: indexPath)
        if let cell = cell as? EventCell{
            cell.event = events[indexPath.row]
        }
        return cell
    }

}
