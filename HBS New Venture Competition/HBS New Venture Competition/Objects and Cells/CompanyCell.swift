//
//  CompanyCell.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 10/17/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class CompanyCell: UICollectionViewCell {
    
    static let identifier = "CompanyCell"
    
    //outlets
    @IBOutlet weak var logoImageView: AsyncImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    
    //data source
    var company: Company! { didSet{ reloadData() }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    private func reloadData(){
        logoImageView.setFirebaseURL(firebaseURL: company.logoImageURL)
        nameLabel.text = company.name
        descriptionLabel.text = company.description
    }
    
}
