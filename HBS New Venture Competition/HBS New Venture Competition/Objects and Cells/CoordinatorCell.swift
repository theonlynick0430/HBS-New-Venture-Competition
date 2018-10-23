//
//  CoordinatorCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class CoordinatorCell: UITableViewCell {
    
    static let identifier = "CoordinatorCell"

    //outlets
    @IBOutlet weak var profileImageView: AsyncImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var linkedInBtn: UIButton!
    
    //data source
    var coordinator: Coordinator! { didSet{ reloadData() }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //rounds corners
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        linkedInBtn.layer.masksToBounds = true
        linkedInBtn.layer.cornerRadius = linkedInBtn.frame.width/2
        
        //adds borders
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func reloadData(){
        profileImageView.setFirebaseURL(firebaseURL: coordinator.profileImageURL)
        nameLabel.text = "\(coordinator.firstName) \(coordinator.lastName)"
        positionLabel.text = coordinator.position
        organizationLabel.text = coordinator.organization
        linkedInBtn.addTarget(self, action: #selector(CoordinatorCell.openLinkedIn(_:)), for: .touchUpInside)
    }
    
    @objc private func openLinkedIn(_ sender: UIButton){
        if UIApplication.shared.canOpenURL(coordinator.linkedInURL){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(coordinator.linkedInURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(coordinator.linkedInURL)
            }
        }
    }
    
}
