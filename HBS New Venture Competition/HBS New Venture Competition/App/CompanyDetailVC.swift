//
//  CompanyDetailVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/22/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class CompanyDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //outlets
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return UITableViewCell()
    }

}
