//
//  AppStorage.swift
//  HBS New Venture Competition
//
//  Created by Nikhil Sridhar on 9/24/18.
//  Copyright © 2018 HBS. All rights reserved.
//

import Foundation

//stores basic information locally
//functionality includes saving and loading from UserDefaults
//operates completely independent from firebase

public class AppStorage{
    
    static var eventCode: String?
    
    static func save(){
        let defaults = UserDefaults.standard
        defaults.set(eventCode, forKey: NameFile.UserDefaults.eventCode)
    }
    
    static func load(){
        let defaults = UserDefaults.standard
        eventCode = defaults.value(forKey: NameFile.UserDefaults.eventCode) as? String
    }
    
    static func clearUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
}
