//
//  EventCodeVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/24/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import FasterVerificationCode
import SVProgressHUD
import PopupDialog

class EventCodeVC: UIViewController, VerificationCodeViewDelegate {
    
    //outlets
    @IBOutlet var verificationCodeView: VerificationCodeView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        verificationCodeView.setLabelNumber(5)
        verificationCodeView.delegate = self
    }
    
    // MARK: - VerificationCodeViewDelegate
    
    func verificationCodeInserted(_ text: String, isComplete: Bool){
        
        SVProgressHUD.show()
        
        verify(eventCode: text) { (verified, error) in
            SVProgressHUD.dismiss()
            guard let verified = verified, error == nil else{
                self.issueAlert(ofType: .requestFailed)
                return
            }
            
            if verified{
                let appStoryboard = UIStoryboard(name: "App", bundle: Bundle.main)
                if let tabVC = appStoryboard.instantiateInitialViewController(){
                    self.present(tabVC, animated: true, completion: nil)
                }
            }else{
                let popup = PopupDialog(title: "Error", message: "The code you entered is wrong", image: nil, buttonAlignment: .horizontal, transitionStyle: .bounceDown, preferredWidth: self.view.frame.width - 100, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
                popup.addButton(CancelButton(title: "OK", height: 60, dismissOnTap: true, action: nil))
                self.present(popup, animated: true, completion: nil)
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
