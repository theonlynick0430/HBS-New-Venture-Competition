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
    
    @IBOutlet var toBottom: NSLayoutConstraint!
    
    private var bottomSafeAreaInset: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //sets delegates
        verificationCodeView.delegate = self
        
        verificationCodeView.setLabelNumber(5)
        
        toBottom.constant = view.frame.height/2
    }
    
    override func viewSafeAreaInsetsDidChange() {
        super.viewSafeAreaInsetsDidChange()
        bottomSafeAreaInset =  view.safeAreaInsets.bottom
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: .UIKeyboardWillShow, object: nil)
        verificationCodeView.becomeFirstResponder()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        SVProgressHUD.dismiss()
        NotificationCenter.default.removeObserver(self)
        view.endEditing(true)
    }
    
    // MARK: - Keyboard
    
    @objc func keyboardWillShow(notification: Notification) {
        let userInfo = notification.userInfo! as NSDictionary
        let keyboardFrame = userInfo.value(forKey: UIKeyboardFrameEndUserInfoKey) as! NSValue
        let keyboardRectangle = keyboardFrame.cgRectValue
        let keyboardHeight = keyboardRectangle.height
        
        toBottom.constant = keyboardHeight + 150 - bottomSafeAreaInset
    }
    
    // MARK: - Verification Code View Delegate
    
    func verificationCodeInserted(_ text: String, isComplete: Bool){
        
        SVProgressHUD.show()
        
        verify(eventCode: text) { (verified, error) in
            SVProgressHUD.dismiss()
            guard let verified = verified, error == nil else{
                self.issueAlert(ofType: .requestFailed)
                return
            }
            
            if verified{
                AppStorage.eventCode = self.dbEventCode!
                AppStorage.save()
                
                let appStoryboard = UIStoryboard(name: "App", bundle: Bundle.main)
                if let tabVC = appStoryboard.instantiateInitialViewController(){
                    self.present(tabVC, animated: true, completion: nil)
                }
            }else{
                let popup = PopupDialog(title: "Error", message: "The code you entered is incorrect", image: nil, buttonAlignment: .horizontal, transitionStyle: .bounceDown, preferredWidth: self.view.frame.width - 100, tapGestureDismissal: true, panGestureDismissal: false, hideStatusBar: false, completion: nil)
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
    
    // MARK: - Trait Collection Delegate
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        if view.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClass.regular{
            verificationCodeView.labelWidth = 60
            verificationCodeView.labelSpacing = 20
        }
    }
    
}
