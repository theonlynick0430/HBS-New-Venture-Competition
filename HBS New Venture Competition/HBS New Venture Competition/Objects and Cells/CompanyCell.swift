//
//  CompanyCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class CompanyCell: UICollectionViewCell {
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    var company: Company! {didSet{setData()}}
    
    private func setData(){
        nameLabel.text = company.name
        descriptionLabel.text = company.description
    }
    
}
