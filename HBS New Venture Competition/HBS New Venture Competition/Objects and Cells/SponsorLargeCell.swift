//
//  SponsorLargeCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/22/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class SponsorLargeCell: UITableViewCell {
    
    static let identifier = "SponsorLargeCell"
    
    //outlets
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var websiteLabel: UILabel!
    @IBOutlet weak var prizeLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var repProfileImageView: UIImageView!
    @IBOutlet weak var repNameLabel: UILabel!
    @IBOutlet weak var repEmailLabel: UILabel!
    

    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
