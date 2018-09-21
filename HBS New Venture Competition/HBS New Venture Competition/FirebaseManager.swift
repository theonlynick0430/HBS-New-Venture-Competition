//
//  FirebaseManager.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/20/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation
import FirebaseFirestore
import FirebaseStorage

class FirebaseManager{
    
    public typealias CompletionHandler = (Error?) -> Void
    public typealias CompanyCallback = ([Company]?, Error?) -> Void
    public typealias EventCallback = ([Event]?, Error?) -> Void
    public typealias JudgeCallback = ([Judge]?, Error?) -> Void
    public typealias SponsorCallback = ([Sponsor]?, Error?) -> Void
    public typealias CoordinatorCallback = ([Coordinator]?, Error?) -> Void
    
    public static let manager = FirebaseManager()
    
    // MARK: - Firestore References
    
    private let database = Firestore.firestore()
    private let companies = Firestore.firestore().collection(NameFile.Firebase.CompanyDB.companies)
    private let events = Firestore.firestore().collection(NameFile.Firebase.EventDB.events)
    private let judges = Firestore.firestore().collection(NameFile.Firebase.JudgeDB.judges)
    private let sponsors = Firestore.firestore().collection(NameFile.Firebase.SponsorDB.sponsors)
    private let coordinators = Firestore.firestore().collection(NameFile.Firebase.CoordinatorDB.coordinators)
    
    // Manager Functions
    
    // Fetches all companies
    public func fetchCompanies(_ callback: @escaping CompanyCallback){
        
    }
    
    // Fetches all events
    public func fetchEvents(_ callback: @escaping EventCallback){
        
    }
    
    // Fetches all judges
    public func fetchJudges(_ callback: @escaping JudgeCallback){
        
    }
    
    // Fetches all sponsors
    public func fetchSponsors(_ callback: @escaping SponsorCallback){
        
    }
    
    // Fetches all coordinators
    public func fetchCoordinators(_ callback: @escaping CoordinatorCallback){
        
    }
    
}
