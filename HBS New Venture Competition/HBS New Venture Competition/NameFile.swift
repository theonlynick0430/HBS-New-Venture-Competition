//
//  NameFile.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/19/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation

struct NameFile {
    
    struct Firebase{
        
        struct Companies{
            //companies <collection>
            static let companies = "Companies"
                //company <document> - random ID
            static let name = "Name"
            static let description = "Description"
            static let logoImageURL = "LogoImageURL"
                    //members <collection>
                        //member <document> - randomID
            static let firstName = "FirstName"
            static let lastName = "LastName"
            static let profileImageURL = "ProfileImageURL"
            static let email = "Email"
            static let phoneNumber = "PhoneNumber"
            static let linkedInURL = "LinkedInURL"
            static let education = "Education"
            static let position = "Position"
            static let order = "Order"
        }
        
        struct Events{
            //events <collection>
            static let events = "Events"
                //event <document> - random ID
            static let time = "Time"
            static let description = "Description"
        }
        
        struct Judges{
            //judges <collection>
            static let judges = "Judges"
                //judge <document> - random ID
            static let firstName = "FirstName"
            static let lastName = "LastName"
            static let profileImageURL = "ProfileImageURL"
            static let email = "Email"
            static let description = "Description"
        }
        
        struct Sponsors{
            //sponsors <collection>
            static let sponsors = "Sponsors"
                //sponsor <document> - random ID
            static let name = "Name"
            static let description = "Description"
            static let logoImageURL = "logoImageURL"
            static let prize = "Prize"
            static let website = "Website"
            static let repFirstName = "RepFirstName"
            static let repLastName = "RepLastName"
            static let repEmail = "RepEmail"
        }
        
        struct Coordinators {
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
