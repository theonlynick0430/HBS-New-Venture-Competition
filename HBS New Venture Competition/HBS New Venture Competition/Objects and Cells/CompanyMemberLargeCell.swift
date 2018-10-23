//
//  CompanyMemberLargeCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/22/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class CompanyMemberLargeCell: UITableViewCell {
    
    static let identifier = "CompanyMemberLargeCell"
    
    //outlets
    @IBOutlet weak var profileImageView: AsyncImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var linkedInBtn: UIButton!
    
    //data source
    var companyMember: CompanyMember! { didSet{ reloadData() }}
    
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
        profileImageView.setFirebaseURL(firebaseURL: companyMember.profileImageURL)
        nameLabel.text = "\(companyMember.firstName) \(companyMember.lastName)"
        emailLabel.text = companyMember.email
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(CompanyMemberLargeCell.openEmail(_:)))
        emailLabel.isUserInteractionEnabled = true
        emailLabel.addGestureRecognizer(tapGestureRecognizer)
        positionLabel.text = companyMember.position
        educationLabel.text = companyMember.education
        phoneBtn.addTarget(self, action: #selector(CompanyMemberLargeCell.openPhoneNumber(_:)), for: .touchUpInside)
        linkedInBtn.addTarget(self, action: #selector(CompanyMemberLargeCell.openLinkedIn(_:)), for: .touchUpInside)
    }
    
    @objc private func openEmail(_ sender: UIButton){
        if let url = URL(string: "mailto:\(companyMember.email)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

    @objc private func openLinkedIn(_ sender: UIButton){
        if UIApplication.shared.canOpenURL(companyMember.linkedInURL){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(companyMember.linkedInURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(companyMember.linkedInURL)
            }
        }
    }
    
    @objc private func openPhoneNumber(_ sender: UIButton){
        if let url = URL(string: "tel://\(companyMember.phoneNumber)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }
    
}
