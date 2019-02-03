//
//  CompanyDetailVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/22/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import Cosmos
import SVProgressHUD
import ESPullToRefresh
import PopupDialog

class CompanyDetailVC: UIViewController, UITableViewDelegate, UITableViewDataSource {

    //outlets
    @IBOutlet weak var headerLabel: UILabel!
    @IBOutlet weak var backBtn: UIButton!
    @IBOutlet weak var logoImageView: AsyncImageView!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var ratingsView: CosmosView!
    @IBOutlet weak var notesBtn: UIButton!
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
        
        //rounds corners
        notesBtn.layer.masksToBounds = true
        notesBtn.layer.cornerRadius = notesBtn.frame.width/10
        
        notesBtn.addTarget(self, action: #selector(CompanyDetailVC.segueToNotes(_:)), for: .touchUpInside)
        
        setupRefresh()
        setupRatings()
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        //setup
        fetchCompanyMembers()
    }
    
    // MARK: - Essential Functions
    
    private func fetchCompanyMembers(){
        
        SVProgressHUD.show()
        
        FirebaseManager.manager.fetchCompanyMembers(companyID: company.companyID) { (companyMembers, error) in
            SVProgressHUD.dismiss()
            guard let companyMembers = companyMembers, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.companyMembers = companyMembers
            self.companyMembers.sort(by: { "\($0.firstName) \($0.lastName)" < "\($1.firstName) \($1.lastName)" })
        }
    }
    
    // MARK: - Helper Functions
    
    private func setupRatings(){
        ratingsView.didFinishTouchingCosmos = { rating in
            if AppStorage.eventCode != nil{
                if rating != self.company.stars{
                    FirebaseManager.manager.addVote(self.company.companyID, rating: rating, completionHandler: { (error) in
                        guard error == nil else{
                            self.ratingsView.rating = self.company.stars
                            self.issueAlert(ofType: .requestFailed)
                            return
                        }
                        
                        self.company.stars = rating
                    })
                }
            }else{
                self.ratingsView.rating = self.company.stars
                let popup = PopupDialog(title: "Invalid", message: "Voting is not enabled on this device. To enable it, go to the the startups tab, click the Vote button in the upper right hand corner, and enter the event code.", image: nil, buttonAlignment: .horizontal, transitionStyle: .bounceDown, preferredWidth: self.view.frame.width - 100, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
                popup.addButton(CancelButton(title: "OK", height: 60, dismissOnTap: true, action: nil))
                self.present(popup, animated: true, completion: nil)
            }
        }
    }
    
    private func setupRefresh(){
        tableView.es.addPullToRefresh {
            self.tableView.es.stopPullToRefresh()
            self.fetchCompanyMembers()
        }
    }
    
    private func loadData(){
        headerLabel.text = company.name
        logoImageView.setFirebaseURL(firebaseURL: company.logoImageURL)
        descriptionTV.text = company.description
        ratingsView.rating = company.stars
    }
    
    // MARK: - Tableview Delegate and Datasource
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 144
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return companyMembers.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if UIDevice.current.deviceIsiPad{
            let cell = tableView.dequeueReusableCell(withIdentifier: CompanyMemberLargeCell.identifier, for: indexPath)
            if let cell = cell as? CompanyMemberLargeCell{
                cell.companyMember = companyMembers[indexPath.row]
            }
            return cell
        }else{
            let cell = tableView.dequeueReusableCell(withIdentifier: CompanyMemberCell.identifier, for: indexPath)
            if let cell = cell as? CompanyMemberCell{
                cell.companyMember = companyMembers[indexPath.row]
            }
            return cell
        }
    }
    
    // MARK: - Navigation
    
    @objc private func segueToNotes(_ sender: UIButton){
        performSegue(withIdentifier: NameFile.Segues.toNotes, sender: sender)
    }
    
    @IBAction func unwindToCompanyDetail(segue: UIStoryboardSegue) {}
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let notesVC = segue.destination as? NotesVC{
            notesVC.company = company
        }
    }

}
