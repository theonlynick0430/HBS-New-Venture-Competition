//
//  JudgeCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class JudgeCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var linkedInBtn: UIButton!
    
    var judge: Judge! { didSet { setData() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    private func setData(){
        nameLabel.text = judge.firstName + " " + judge.lastName
        descriptionLabel.text = judge.description
    }
    
}
