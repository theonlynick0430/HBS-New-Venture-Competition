//
//  CoordinatorCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class CoordinatorCell: UITableViewCell {

    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var positionLabel: UILabel!
    @IBOutlet weak var organizationLabel: UILabel!
    @IBOutlet weak var linkedInBtn: UIButton!
    
    var coordinator: Coordinator! { didSet { setData() } }
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func setData(){
        nameLabel.text = coordinator.firstName + " " + coordinator.lastName
        positionLabel.text = coordinator.position
        organizationLabel.text = coordinator.organization
    }
    
}
