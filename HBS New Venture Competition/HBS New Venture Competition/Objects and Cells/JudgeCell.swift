//
//  JudgeCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class JudgeCell: UITableViewCell {
    
    static let identifier = "JudgeCell"
    
    //outlets
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var linkedInBtn: UIButton!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
}
