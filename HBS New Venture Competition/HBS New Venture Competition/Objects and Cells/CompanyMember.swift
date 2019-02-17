//
//  CompanyMember.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/20/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation

class CompanyMember{
    
    var firstName: String
    var lastName: String
    var profileImageURL: String
    var email: String
    var phoneNumber: String
    var linkedInURL: URL
    var education: String
    var position: String
    var order: Int
    
    //initializer
    init(firstName: String, lastName: String, profileImageURL: String, email: String, phoneNumber: String, linkedInURL: URL, education: String, position: String, order: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.profileImageURL = profileImageURL
        self.email = email
        self.phoneNumber = phoneNumber
        self.linkedInURL = linkedInURL
        self.education = education
        self.position = position
        self.order = order
    }
    
}

