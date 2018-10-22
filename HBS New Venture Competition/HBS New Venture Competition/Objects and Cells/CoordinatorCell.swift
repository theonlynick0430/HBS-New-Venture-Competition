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
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var linkedInBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
