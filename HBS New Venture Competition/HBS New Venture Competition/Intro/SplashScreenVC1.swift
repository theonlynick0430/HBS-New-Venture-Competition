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
        
        view.layoutIfNeeded()
        
        if UIDevice.deviceType == .smalliPhone{
            headerViewHeight.constant = 0
        }
    }
    
}
