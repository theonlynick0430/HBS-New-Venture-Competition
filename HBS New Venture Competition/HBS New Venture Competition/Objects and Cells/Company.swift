//
//  Company.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/20/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation

class Company{
    
    var companyID: String
    var name: String
    var description: String
    var notes: String
    var logoImageURL: String
    var order: Int
    var stars: Double
    
    //initializer
    init(companyID: String, name: String, description: String, notes: String, logoImageURL: String, order: Int, stars: Double) {
        self.companyID = companyID
        self.name = name
        self.description = description
        self.notes = notes
        self.logoImageURL = logoImageURL
        self.order = order
        self.stars = stars
    }
    
}
