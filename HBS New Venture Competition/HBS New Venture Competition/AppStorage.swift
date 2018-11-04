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
    static var displaySplashScreen = true
    
    static func save(){
        let defaults = UserDefaults.standard
        defaults.set(eventCode, forKey: NameFile.UserDefaults.eventCode)
        defaults.set(displaySplashScreen, forKey: NameFile.UserDefaults.displaySplashScreen)
    }
    
    static func load(){
        let defaults = UserDefaults.standard
        eventCode = defaults.value(forKey: NameFile.UserDefaults.eventCode) as? String
        displaySplashScreen = defaults.value(forKey: NameFile.UserDefaults.displaySplashScreen) as? Bool ?? true
    }
    
    static func clearUserDefaults() {
        let domain = Bundle.main.bundleIdentifier!
        UserDefaults.standard.removePersistentDomain(forName: domain)
        UserDefaults.standard.synchronize()
    }
    
}
