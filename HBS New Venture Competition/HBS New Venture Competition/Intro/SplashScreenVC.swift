//
//  SplashScreenVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 11/3/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit

class SplashScreenVC: UIViewController {
    
    //outlets
    @IBOutlet weak var continueBtn: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        continueBtn.addTarget(self, action: #selector(SplashScreenVC.continueToApp(_:)), for: .touchUpInside)
    }
    
    @objc private func continueToApp(_ sender: UIButton){
        let appStoryboard = UIStoryboard(name: "App", bundle: Bundle.main)
        if let tabVC = appStoryboard.instantiateInitialViewController(){
            self.present(tabVC, animated: true, completion: nil)
        }
    }
    
}
