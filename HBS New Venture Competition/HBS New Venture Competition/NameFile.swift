//
//  NameFile.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/19/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation

struct NameFile {
    
    struct UserDefaults{
        static let eventCode = "EventCode"
    }
    
    struct Segues {
        static let toCompanyDetail = "SegueToCompanyDetail"
    }
    
    struct Firebase{
        
        struct CodeDB{
            //codes <collection>
            static let codes = "Codes"
            static let eventCode = "EventCode"
                //event code <document> - constant
            static let code = "Code"
        }
        
        struct CompanyDB{
            //companies <collection>
            static let companies = "Companies"
                //company <document> - random ID
            static let name = "Name"
            static let description = "Description"
            static let logoImageURL = "LogoImageURL"
            static let order = "Order"
                    //members <collection>
            static let members = "Members"
                        //member <document> - randomID
            static let firstName = "FirstName"
            static let lastName = "LastName"
            static let profileImageURL = "ProfileImageURL"
            static let email = "Email"
            static let phoneNumber = "PhoneNumber"
            static let linkedInURL = "LinkedInURL"
            static let education = "Education"
            static let position = "Position"
                    //votes <collection>
            static let votes = "Votes"
                        //vote <document> - deviceID
            static let stars = "Stars"
        }
        
        struct EventDB{
            //events <collection>
            static let events = "Events"
            static let currentEvent = "CurrentEvent"
                //current event - "CurrentEvent"
            static let currentEventID = "CurrentEventID"
                //event <document> - random ID
            static let time = "Time"
            static let description = "Description"
        }
        
        struct JudgeDB{
            //judges <collection>
            static let judges = "Judges"
                //judge <document> - random ID
            static let firstName = "FirstName"
            static let lastName = "LastName"
            static let profileImageURL = "ProfileImageURL"
            static let linkedInURL = "LinkedInURL"
            static let description = "Description"
        }
        
        struct SponsorDB{
            //sponsors <collection>
            static let sponsors = "Sponsors"
                //sponsor <document> - random ID
            static let name = "Name"
            static let description = "Description"
            static let logoImageURL = "logoImageURL"
            static let prize = "Prize"
            static let website = "Website"
            static let repProfileImageURL = "RepProfileImageURL"
            static let repFirstName = "RepFirstName"
            static let repLastName = "RepLastName"
            static let repEmail = "RepEmail"
        }
        
        struct CoordinatorDB{
            //coordinators <collection>
            static let coordinators = "Coordinators"
                //coordinator <document> - random ID
            static let firstName = "FirstName"
            static let lastName = "LastName"
            static let profileImageURL = "ProfileImageURL"
            static let position = "Position"
            static let organization = "Organization"
            static let linkedInURL = "LinkedInURL"
        }
        
    }
    
}
