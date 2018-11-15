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
            if notes.count == 0{
                self.notesTV.text = "Enter your notes here..."
                self.notesTV.textColor = UIColor.lightGray
            }
        }
    }
    
    // MARK: - UITextViewDelegate
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if notesTV.textColor == UIColor.lightGray {
            notesTV.text = nil
            notesTV.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        
        if notesTV.text.isEmpty {
            notesTV.text = "Enter your notes here..."
            notesTV.textColor = UIColor.lightGray
        }
        
        SVProgressHUD.show()
        
        FirebaseManager.manager.addNotes(companyID: company.companyID, notes: textView.text) { (error) in
            SVProgressHUD.dismiss()
            if error != nil{
                self.issueAlert(ofType: .requestFailed)
            }
        }
    }

}
