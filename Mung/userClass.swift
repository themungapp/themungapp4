//
//  userClass.swift
//  Mung
//
//  Created by Chike Chiejine on 13/10/2016.
//  Copyright © 2016 Color & Space. All rights reserved.
//

import UIKit

class User {
    
    var userID: String
    var userName: String
    var userEmailVerified: Bool
    var userPassword: String
    var userJoinTimeStamp: String
    var userLocation: String
    var userLastLoginTimeStamp: String
    var userVerified: Bool
    var userGoals: NSArray  // {"chinatrip123": true, "playstation": true, "yeezes": true, "hermesbracelet": true }
    var userImage: String
    
    init(userID: String, userName: String, userEmailVerified: Bool, userPassword:String, userJoinTimeStamp: String, userLocation: String, userLastLoginTimeStamp: String,
         userVerified: Bool, userGoals: NSArray, userImage: String){
        
        self.userID = userID
        self.userName = userName
        self.userEmailVerified = userEmailVerified
        self.userPassword = userPassword
        self.userJoinTimeStamp = userJoinTimeStamp
        self.userLocation = userLocation
        self.userLastLoginTimeStamp = userLastLoginTimeStamp
        self.userVerified = userVerified
        self.userGoals = userGoals
        self.userImage = userImage
        
   }
}

