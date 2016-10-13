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

    var firstName: String
    var lastName: String
    var photo: String //must be stored as a string for the filename.

        var email: String
        var bio: String
        var listOfFriendsOnTheApp: NSArray



    init(firstName: String, lastName: String, photo: String, email:String, userID: String){
        self.firstName = firstName
        self.lastName = lastName
        self.photo = photo
        self.listOfFriendsOnTheApp = []
        self.bio = ""
        self.email = email
        self.userID = userID
   }
}

