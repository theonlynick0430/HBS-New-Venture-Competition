//
//  FirebaseManager.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/20/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation
import Firebase

class FirebaseManager{
    
    public typealias CompletionHandler = (Error?) -> Void
    public typealias EventCodeCallback = (String?, Error?) -> Void
    public typealias CompanyCallback = ([Company]?, Error?) -> Void
    public typealias CompanyMemberCallback = ([CompanyMember]?, Error?) -> Void
    public typealias EventCallback = ([Event]?, Error?) -> Void
    public typealias JudgeCallback = ([Judge]?, Error?) -> Void
    public typealias SponsorCallback = ([Sponsor]?, Error?) -> Void
    public typealias CoordinatorCallback = ([Coordinator]?, Error?) -> Void
    
    public static let manager = FirebaseManager()
    
    // MARK: - Firestore References
    
    private let database = Firestore.firestore()
    private let codes = Firestore.firestore().collection(NameFile.Firebase.CodeDB.codes)
    private let companies = Firestore.firestore().collection(NameFile.Firebase.CompanyDB.companies)
    private let events = Firestore.firestore().collection(NameFile.Firebase.EventDB.events)
    private let judges = Firestore.firestore().collection(NameFile.Firebase.JudgeDB.judges)
    private let sponsors = Firestore.firestore().collection(NameFile.Firebase.SponsorDB.sponsors)
    private let coordinators = Firestore.firestore().collection(NameFile.Firebase.CoordinatorDB.coordinators)
    
    // The Firestore reference to the event code document
    private var EVENT_CODE_DOC: DocumentReference {
        return codes.document(NameFile.Firebase.CodeDB.eventCode)
    }
    
    // Manager Functions
    
    // Fetches the event code
    public func fetchEventCode(_ callback: @escaping EventCodeCallback){
        EVENT_CODE_DOC.getDocument { (document, error) in
            guard let document = document, document.exists, let data = document.data(), error == nil else{
                print("FIREBASE EVENT CODE FETCH ERROR: \(String(describing: error?.localizedDescription))")
                callback(nil, error)
                return
            }
            
            let code = data[NameFile.Firebase.CodeDB.code] as! String
            callback(code, nil)
        }
    }
    
    // Fetches all companies
    public func fetchCompanies(_ callback: @escaping CompanyCallback){
        companies.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else{
                print("FIREBASE COMPANY FETCH ERROR: \(String(describing: error?.localizedDescription))")
                callback(nil, error)
                return
            }
            
            var companies = [Company]()
            let dispatch = DispatchGroup()
            documents.forEach({ (document) in
                let data = document.data()
                let companyID = document.documentID
                let name = data[NameFile.Firebase.CompanyDB.name] as! String
                let description = data[NameFile.Firebase.CompanyDB.description] as! String
                let logoImageURL = data[NameFile.Firebase.CompanyDB.logoImageURL] as! String
                let order = data[NameFile.Firebase.CompanyDB.order] as! Int
                
                dispatch.enter()
                self.companies.document(companyID).collection(NameFile.Firebase.CompanyDB.votes).document(UIDevice.current.identifierForVendor!.uuidString).getDocument(completion: { (document, error) in
                    if let document = document, document.exists, let data = document.data(), let stars = data[NameFile.Firebase.CompanyDB.stars] as? Int{
                        companies.append(Company(companyID: companyID, name: name, description: description, logoImageURL: logoImageURL, order: order, stars: stars))
                    }else{
                        companies.append(Company(companyID: companyID, name: name, description: description, logoImageURL: logoImageURL, order: order, stars: 0))
                    }
                    dispatch.leave()
                })
            })
            dispatch.notify(queue: .main, execute: {
                callback(companies, nil)
            })
        }
    }
    
    // Fetches all members inside a company
    public func fetchCompanyMembers(companyID: String, callback: @escaping CompanyMemberCallback){
        companies.document(companyID).collection(NameFile.Firebase.CompanyDB.members).getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else{
                print("FIREBASE COMPANY MEMBER FETCH ERROR: \(String(describing: error?.localizedDescription))")
                callback(nil, error)
                return
            }
            
            var companyMembers = [CompanyMember]()
            documents.forEach({ (document) in
                let data = document.data()
                let firstName = data[NameFile.Firebase.CompanyDB.firstName] as! String
                let lastName = data[NameFile.Firebase.CompanyDB.lastName] as! String
                let profileImageURL = data[NameFile.Firebase.CompanyDB.profileImageURL] as! String
                let email = data[NameFile.Firebase.CompanyDB.email] as! String
                let phoneNumber = data[NameFile.Firebase.CompanyDB.phoneNumber] as! String
                let linkedInURL = URL(string: data[NameFile.Firebase.CompanyDB.linkedInURL] as! String)!
                let education = data[NameFile.Firebase.CompanyDB.education] as! String
                let position = data[NameFile.Firebase.CompanyDB.position] as! String
                companyMembers.append(CompanyMember(firstName: firstName, lastName: lastName, profileImageURL: profileImageURL, email: email, phoneNumber: phoneNumber, linkedInURL: linkedInURL, education: education, position: position))
            })
            callback(companyMembers, nil)
        }
    }
    
    // Adds a device specific vote to a company
    public func addVote(_ companyID: String, stars: Int, completionHandler: CompletionHandler? = nil){
        companies.document(companyID).collection(NameFile.Firebase.CompanyDB.votes).document(UIDevice.current.identifierForVendor!.uuidString).setData([NameFile.Firebase.CompanyDB.stars : stars], completion: completionHandler)
    }
    
    // Fetches all events
    public func fetchEvents(_ callback: @escaping EventCallback){
        events.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else{
                print("FIREBASE EVENT FETCH ERROR: \(String(describing: error?.localizedDescription))")
                callback(nil, error)
                return
            }
            
            var events = [Event]()
            documents.forEach({ (document) in
                let data = document.data()
                let time = data[NameFile.Firebase.EventDB.time] as! Timestamp
                let description = data[NameFile.Firebase.EventDB.description] as! String
                events.append(Event(time: time, description: description))
            })
            callback(events, nil)
        }
    }
    
    // Fetches all judges
    public func fetchJudges(_ callback: @escaping JudgeCallback){
        judges.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else{
                print("FIREBASE JUDGE FETCH ERROR: \(String(describing: error?.localizedDescription))")
                callback(nil, error)
                return
            }
            
            var judges = [Judge]()
            documents.forEach({ (document) in
                let data = document.data()
                let firstName = data[NameFile.Firebase.JudgeDB.firstName] as! String
                let lastName = data[NameFile.Firebase.JudgeDB.lastName] as! String
                let profileImageURL = data[NameFile.Firebase.JudgeDB.profileImageURL] as! String
                let linkedInURL = URL(string: data[NameFile.Firebase.JudgeDB.linkedInURL] as! String)!
                let description = data[NameFile.Firebase.JudgeDB.description] as! String
                judges.append(Judge(firstName: firstName, lastName: lastName, profileImageURL: profileImageURL, linkedInURL: linkedInURL, description: description))
            })
            callback(judges, nil)
        }
    }
    
    // Fetches all sponsors
    public func fetchSponsors(_ callback: @escaping SponsorCallback){
        sponsors.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else{
                print("FIREBASE SPONSOR FETCH ERROR: \(String(describing: error?.localizedDescription))")
                callback(nil, error)
                return
            }
            
            var sponsors = [Sponsor]()
            documents.forEach({ (document) in
                let data = document.data()
                let name = data[NameFile.Firebase.SponsorDB.name] as! String
                let description = data[NameFile.Firebase.SponsorDB.description] as! String
                let logoImageURL = data[NameFile.Firebase.SponsorDB.logoImageURL] as! String
                let prize = data[NameFile.Firebase.SponsorDB.prize] as! String
                let website = URL(string: data[NameFile.Firebase.SponsorDB.website] as! String)!
                let repFirstName = data[NameFile.Firebase.SponsorDB.repFirstName] as! String
                let repLastName = data[NameFile.Firebase.SponsorDB.repLastName] as! String
                let repEmail = data[NameFile.Firebase.SponsorDB.repEmail] as! String
                sponsors.append(Sponsor(name: name, description: description, logoImageURL: logoImageURL, prize: prize, website: website, repFirstName: repFirstName, repLastName: repLastName, repEmail: repEmail))
            })
            callback(sponsors, nil)
        }
    }
    
    // Fetches all coordinators
    public func fetchCoordinators(_ callback: @escaping CoordinatorCallback){
        coordinators.getDocuments { (snapshot, error) in
            guard let documents = snapshot?.documents, error == nil else{
                print("FIREBASE COORDINATOR FETCH ERROR: \(String(describing: error?.localizedDescription))")
                callback(nil, error)
                return
            }
            
            var coordinators = [Coordinator]()
            documents.forEach({ (document) in
                let data = document.data()
                let firstName = data[NameFile.Firebase.CoordinatorDB.firstName] as! String
                let lastName = data[NameFile.Firebase.CoordinatorDB.lastName] as! String
                let profileImageURL = data[NameFile.Firebase.CoordinatorDB.profileImageURL] as! String
                let position = data[NameFile.Firebase.CoordinatorDB.position] as! String
                let organization = data[NameFile.Firebase.CoordinatorDB.position] as! String
                let linkedInURL = URL(string: data[NameFile.Firebase.CoordinatorDB.linkedInURL] as! String)!
                coordinators.append(Coordinator(firstName: firstName, lastName: lastName, profileImageURL: profileImageURL, position: position, organization: organization, linkedInURL: linkedInURL))
            })
            callback(coordinators, nil)
        }
    }
    
}
