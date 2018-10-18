//
//  SponsorCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class SponsorCell: UITableViewCell {

    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var prizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var repProfileImageView: UIImageView!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var repEmailLabel: UILabel!
    
    var sponsor: Sponsor! {didSet{setData()}}
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setData(){
        nameLabel.text = sponsor.name
        websiteLabel.text = sponsor.website.absoluteString
        prizeLabel.text = sponsor.prize
        descriptionLabel.text = sponsor.description
        repNameLabel.text = sponsor.repFirstName + " " + sponsor.repLastName
        repEmailLabel.text = sponsor.repEmail
    }

}
