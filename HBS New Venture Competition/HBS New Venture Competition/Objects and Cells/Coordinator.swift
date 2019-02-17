//
//  Coordinator.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/20/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation

class Coordinator{
    
    var firstName: String
    var lastName: String
    var profileImageURL: String
    var position: String
    var organization: String
    var linkedInURL: URL
    var order: Int
    
    //initializer
    init(firstName: String, lastName: String, profileImageURL: String, position: String, organization: String, linkedInURL: URL, order: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.profileImageURL = profileImageURL
        self.position = position
        self.organization = organization
        self.linkedInURL = linkedInURL
        self.order = order
    }
    
}
