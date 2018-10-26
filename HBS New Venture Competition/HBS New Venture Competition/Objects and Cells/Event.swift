//
//  Event.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/20/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation
import Firebase

class Event{
    
    var eventID: String
    var time: Timestamp
    var description: String
    
    //initializer
    init(eventID: String, time: Timestamp, description: String) {
        self.eventID = eventID
        self.time = time
        self.description = description
    }
    
}
