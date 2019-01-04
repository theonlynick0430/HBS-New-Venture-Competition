//
//  SplashScreenVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 11/3/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class SplashScreenVC1: UIViewController {
    
    //outlets
    @IBOutlet weak var headerView: UIView!
    @IBOutlet weak var headerViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerStackView: UIStackView!
    @IBOutlet weak var headerStackViewWidth: NSLayoutConstraint!
    @IBOutlet weak var headerStackViewHeight: NSLayoutConstraint!
    @IBOutlet weak var headerLabel1: UILabel!
    @IBOutlet weak var headerLabel2: UILabel!
    @IBOutlet weak var headerLabel3: UILabel!
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var logoImageViewWidth: NSLayoutConstraint!
    @IBOutlet weak var logoImageViewHeight: NSLayoutConstraint!
    @IBOutlet weak var logoImageToCenter: NSLayoutConstraint!
    @IBOutlet weak var promptLabel: UILabel!
    @IBOutlet weak var promptLabelToTop: NSLayoutConstraint!
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var continueBtnHeight: NSLayoutConstraint!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //rounds corners
        continueBtn.layer.masksToBounds = true
        continueBtn.layer.cornerRadius = 25
        
        switch UIDevice.deviceType {
        case .smalliPhone:
            promptLabelToTop.constant = 30
            logoImageToCenter.constant = -60
            headerViewHeight.constant = 75
            headerStackViewWidth.constant = 310
            headerLabel1.font = UIFont(name: "Avenir-Medium", size: 13)
            headerLabel2.font = UIFont(name: "Avenir-Medium", size: 13)
            headerLabel3.font = UIFont(name: "Avenir-Medium", size: 13)
            headerView.layoutIfNeeded()
        case .largeiPhone:
            break
        case .iPhone:
            break
        case .iPad:
            break
        case .none:
            break
        }
    }
    
}
