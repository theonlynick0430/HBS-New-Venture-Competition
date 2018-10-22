//
//  CompanyMemberCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/22/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class CompanyMemberCell: UITableViewCell {
    
    static let identifier = "CompanyMemberCell"
    
    //outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var educationLabel: UILabel!
    @IBOutlet weak var phoneBtn: UIButton!
    @IBOutlet weak var linkedInBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

}
