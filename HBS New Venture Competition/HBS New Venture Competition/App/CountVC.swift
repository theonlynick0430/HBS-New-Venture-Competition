//
//  CountVC.swift
//  SplitMe
//
//  Created by Nikhil Sridhar on 10/26/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class CountVC: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    //outlets
    @IBOutlet weak var tableView: UITableView!

    var numbers = [Int]()
    var selectedNumber = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets delegates and datasources
        tableView.delegate = self
        tableView.dataSource = self
        
        tableView.tableHeaderView = UIView(frame: .zero)
        tableView.tableFooterView = UIView(frame: .zero)
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numbers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell(style: UITableViewCellStyle.default, reuseIdentifier: "BasicCellID")
        cell.textLabel?.font = UIFont(name: "Avenir-Book", size: 14.0)!
        let number = numbers[indexPath.row]
        cell.textLabel?.text = "\(number)"
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        selectedNumber = numbers[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        tableView.reloadData()
    }
    
}
