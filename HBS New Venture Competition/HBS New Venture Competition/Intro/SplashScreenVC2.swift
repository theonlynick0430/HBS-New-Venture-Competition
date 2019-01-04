//
//  SplashScreenVC2.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 11/4/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class SplashScreenVC2: UIViewController {

    //outlets
    @IBOutlet weak var continueBtn: UIButton!
    @IBOutlet weak var letterTV: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        continueBtn.addTarget(self, action: #selector(SplashScreenVC2.continueToApp(_:)), for: .touchUpInside)
        
        //rounds corners
        continueBtn.layer.masksToBounds = true
        continueBtn.layer.cornerRadius = 25
        letterTV.layer.masksToBounds = true
        letterTV.layer.cornerRadius = 10
    }
    
    override func viewDidLayoutSubviews() {
        self.letterTV.setContentOffset(.zero, animated: false)
    }
    
    // MARK: - Navigation
    
    @objc private func continueToApp(_ sender: UIButton){
        let appStoryboard = UIStoryboard(name: "App", bundle: Bundle.main)
        if let tabVC = appStoryboard.instantiateInitialViewController(){
            self.present(tabVC, animated: true, completion: nil)
        }
    }
    
}
