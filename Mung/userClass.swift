//
//  userClass.swift
//  Mung
//
//  Created by Chike Chiejine on 13/10/2016.
//  Copyright © 2016 Color & Space. All rights reserved.
//

import UIKit
import Foundation
import Firebase
import FirebaseAuth



class User {
    
    var userID: String
    var userName: String
    var userEmail: String
    var userEmailVerified: Bool
    var userPassword: String
    var userJoinTimeStamp: String
    var userLocation: String
    var userLastLoginTimeStamp: String
    var userVerified: Bool
    var userGoals: NSArray  // {"chinatrip123": true, "playstation": true, "yeezes": true, "hermesbracelet": true }
    var userImage: String
    
    
    //authData variable lives globally
    
    /*
    init(authData: FIRUser) {
        userID = authData.uid
        userEmail = authData.email!
        userEmailVerified = authData.isEmailVerified
        userName = authData.displayName!
    }
    */
    
    // if authData exists
    init(authData: FIRUser, userID: String, userName: String, userEmail: String, userEmailVerified: Bool, userPassword:String, userJoinTimeStamp: String, userLocation: String, userLastLoginTimeStamp: String,
         userVerified: Bool, userGoals: NSArray, userImage: String){
        
        self.userID = authData.uid
        self.userName = authData.displayName!
        self.userEmail = authData.email!
        self.userEmailVerified = authData.isEmailVerified
        self.userPassword = userPassword
        self.userJoinTimeStamp = userJoinTimeStamp
        self.userLocation = userLocation
        self.userLastLoginTimeStamp = userLastLoginTimeStamp
        self.userVerified = userVerified
        self.userGoals = userGoals
        self.userImage = userImage
        
   }
    
    // if authData doesn't exist
    init(userID: String, userName: String, userEmail: String, userEmailVerified: Bool, userPassword:String, userJoinTimeStamp: String, userLocation: String, userLastLoginTimeStamp: String,
         userVerified: Bool, userGoals: NSArray, userImage: String){
        
        self.userID = userID
        self.userName = userName
        self.userEmail = userEmail
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

