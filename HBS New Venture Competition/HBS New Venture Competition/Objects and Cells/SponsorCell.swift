//
//  SponsorCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class SponsorCell: UITableViewCell {
    
    static let identifier = "SponsorCell"

    //outlets
    @IBOutlet weak var logoImageView: AsyncImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var prizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var repProfileImageView: AsyncImageView!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var repEmailLabel: UILabel!
    
    //data source
    var sponsor: Sponsor! { didSet{ reloadData() }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //rounds corners
        repProfileImageView.layer.masksToBounds = true
        repProfileImageView.layer.cornerRadius = repProfileImageView.frame.width/2
        
        //adds borders
        repProfileImageView.layer.borderWidth = 1
        repProfileImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func reloadData(){
        logoImageView.setFirebaseURL(firebaseURL: sponsor.logoImageURL)
        nameLabel.text = sponsor.name
        websiteLabel.text = sponsor.website.absoluteString
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(SponsorCell.openWebsite(_:)))
        websiteLabel.isUserInteractionEnabled = true
        websiteLabel.addGestureRecognizer(tapGestureRecognizer)
        prizeLabel.text = sponsor.prize
        descriptionLabel.text = sponsor.description
        repProfileImageView.setFirebaseURL(firebaseURL: sponsor.repProfileImageURL)
        repNameLabel.text = "\(sponsor.repFirstName) \(sponsor.repLastName)"
        repEmailLabel.text = sponsor.repEmail
        let tapGestureRecognizer2 = UITapGestureRecognizer(target: self, action: #selector(SponsorCell.openEmail(_:)))
        repEmailLabel.isUserInteractionEnabled = true
        repEmailLabel.addGestureRecognizer(tapGestureRecognizer2)
    }
    
    @objc private func openWebsite(_ sender: UIButton){
        if UIApplication.shared.canOpenURL(sponsor.website){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(sponsor.website, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(sponsor.website)
            }
        }
    }
    
    @objc private func openEmail(_ sender: UIButton){
        if let url = URL(string: "mailto:\(sponsor.repEmail)"), UIApplication.shared.canOpenURL(url) {
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(url)
            } else {
                UIApplication.shared.openURL(url)
            }
        }
    }

}
