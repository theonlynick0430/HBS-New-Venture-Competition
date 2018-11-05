//
//  EventCodeVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 11/4/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import FasterVerificationCode
import SVProgressHUD

class EventCodeVC: UIViewController, VerificationCodeViewDelegate {
    
    //outlets
    @IBOutlet weak var verificationCodeView: VerificationCodeView!
    
    var executionBlock: ((String) -> Void)!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        verificationCodeView.delegate = self
        
        verificationCodeView.setLabelNumber(5)
    }
    
    // MARK: - Verification Code View Delegate
    
    func verificationCodeInserted(_ text: String, isComplete: Bool){
        
        SVProgressHUD.show()
        
        verify(eventCode: text) { (verified, error) in
            SVProgressHUD.dismiss()
            self.verificationCodeView.showError = false
            guard let verified = verified, error == nil else{
                SVProgressHUD.showError(withStatus: "Request denied")
                return
            }
            
            if verified{
                SVProgressHUD.showSuccess(withStatus: "Voting enabled")
                self.executionBlock(self.dbEventCode!)
            }else{
                self.verificationCodeView.showError = true
            }
        }
    }
    
    // MARK: - Essential Functions
    
    private var dbEventCode: String?
    
    private func verify(eventCode: String, callback: @escaping (Bool?, Error?) -> Void){
        if let dbEventCode = dbEventCode{
            callback(eventCode == dbEventCode, nil)
        }else{
            FirebaseManager.manager.fetchEventCode { (dbEventCode, error) in
                guard let dbEventCode = dbEventCode, error == nil else{
                    callback(nil, error)
                    return
                }
                
                self.dbEventCode = dbEventCode
                callback(eventCode == dbEventCode, nil)
            }
        }
    }

}
