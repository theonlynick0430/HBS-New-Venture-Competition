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
    var linkedInURL: URL
    var description: String
    
    //initializer
    init(firstName: String, lastName: String, profileImageURL: String, linkedInURL: URL, description: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.profileImageURL = profileImageURL
        self.linkedInURL = linkedInURL
        self.description = description
    }
    
}

