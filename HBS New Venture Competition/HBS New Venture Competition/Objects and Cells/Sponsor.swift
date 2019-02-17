//
//  Sponsor.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/20/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation

class Sponsor{
    
    var name: String
    var description: String
    var logoImageURL: String
    var prize: String
    var website: URL
    var repProfileImageURL: String
    var repFirstName: String
    var repLastName: String
    var repEmail: String
    var order: Int
    
    //initializer
    init(name: String, description: String, logoImageURL: String, prize: String, website: URL, repProfileImageURL: String, repFirstName: String, repLastName: String, repEmail: String, order: Int) {
        self.name = name
        self.description = description
        self.logoImageURL = logoImageURL
        self.prize = prize
        self.website = website
        self.repProfileImageURL = repProfileImageURL
        self.repFirstName = repFirstName
        self.repLastName = repLastName
        self.repEmail = repEmail
        self.order = order
    }
    
}
