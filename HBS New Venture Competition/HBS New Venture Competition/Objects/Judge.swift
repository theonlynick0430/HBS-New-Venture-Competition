//
//  Judge.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/20/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation

class Judge{
    
    var firstName: String
    var lastName: String
    var profileImageURL: String
    var email: String
    var description: String
    
    //initializer
    init(firstName: String, lastName: String, profileImageURL: String, email: String, description: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.profileImageURL = profileImageURL
        self.email = email
        self.description = description
    }
    
}

