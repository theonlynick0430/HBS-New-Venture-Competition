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
    @IBOutlet weak var profileImageView: AsyncImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var descriptionTV: UITextView!
    @IBOutlet weak var linkedInBtn: UIButton!
    
    //data source
    var judge: Judge! { didSet{ reloadData() }}
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //rounds corners
        profileImageView.layer.masksToBounds = true
        profileImageView.layer.cornerRadius = profileImageView.frame.width/2
        linkedInBtn.layer.masksToBounds = true
        linkedInBtn.layer.cornerRadius = linkedInBtn.frame.width/2
        if UIDevice.deviceType == .iPad{
            profileImageView.layer.cornerRadius = 75/2
            linkedInBtn.layer.cornerRadius = 30
        }
        
        //adds borders
        profileImageView.layer.borderWidth = 1
        profileImageView.layer.borderColor = UIColor.lightGray.cgColor
    }
    
    private func reloadData(){
        profileImageView.setFirebaseURL(firebaseURL: judge.profileImageURL)
        nameLabel.text = "\(judge.firstName) \(judge.lastName)"
        descriptionTV.text = judge.description
        linkedInBtn.addTarget(self, action: #selector(JudgeCell.openLinkedIn(_:)), for: .touchUpInside)
    }
    
    @objc private func openLinkedIn(_ sender: UIButton){
        if UIApplication.shared.canOpenURL(judge.linkedInURL){
            if #available(iOS 10.0, *) {
                UIApplication.shared.open(judge.linkedInURL, options: [:], completionHandler: nil)
            } else {
                UIApplication.shared.openURL(judge.linkedInURL)
            }
        }
    }
    
}
