//
//  NotesVC.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 11/5/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import UIKit
import SVProgressHUD

class NotesVC: UIViewController, UITextViewDelegate {

    //outlets
    @IBOutlet weak var notesTV: UITextView!
    
    //data source
    var company: Company!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        notesTV.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        //setup
        fetchNotes()
    }
    
    private func fetchNotes(){
        
        SVProgressHUD.show()
        
        FirebaseManager.manager.fetchNotes(companyID: company.companyID) { (notes, error) in
            SVProgressHUD.dismiss()
            guard let notes = notes, error == nil else{
                self.issueAlert(ofType: .dataRetrievalFailed)
                return
            }
            
            self.notesTV.text = notes
        }
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        SVProgressHUD.show()
        
        FirebaseManager.manager.addNotes(companyID: company.companyID, notes: textView.text) { (error) in
            SVProgressHUD.dismiss()
            if error != nil{
                self.issueAlert(ofType: .requestFailed)
            }
        }
    }

}
