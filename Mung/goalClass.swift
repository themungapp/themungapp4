//
//  goalClass.swift
//  Mung
//
//  Created by Jake Dorab on 10/13/16.
//  Copyright © 2016 Color & Space. All rights reserved.
//

import UIKit


class Goal {
    var goalID: String
    var goalName: String
    var goalDescription: String
    
    // goal socials
    var goalLikers: NSArray  //this will be a dictionary of unknown length? { "alovelace": true, "ghopper": true, "eclarke": true }
    var goalTags: NSArray
    var goalLikeCount: Int
    var goalTimeStamp: String
    var goalLastUpdated: String
    var goalAchieved: Bool

    // goal financials
    var goalAmount: Double
    var goalDuration: Double
    var goalCurrentVal: Double
    var goalStartAmount: Double
    var goalTargetVal: Double

    // goal view permissions
    var goalAllowCommenting: Bool
    var goalUndiscoverable: Bool
    var goalHideFinancialInfo: Bool
    var goalHidePieChart: Bool
    var goalAllowCopying: Bool
    var goalFunded: Bool
    var goalImages: NSArray // { "goalImage1": "PATH", "goalImage2": "PATH" }

    //copying
    var goalOriginalID: String
    var goalOriginalCreator: String
    var goalNumberPeopleCopied: Int
    
    
    init(goalID: String, goalName: String, goalDescription: String, goalLikers:NSArray, goalTags: NSArray, goalLikeCount: Int, goalTimeStamp: String, goalLastUpdated: String, goalAchieved: Bool, goalAmount: Double, goalDuration: Double, goalCurrentVal: Double, goalStartAmount: Double, goalTargetVal: Double, goalAllowCommenting: Bool, goalUndiscoverable: Bool, goalHideFinancialInfo: Bool, goalHidePieChart: Bool, goalAllowCopying: Bool, goalFunded: Bool, goalImages: NSArray, goalOriginalID: String, goalOriginalCreator: String, goalNumberPeopleCopied: Int

  ){
        self.goalID = goalID
        self.goalName = goalName
        self.goalDescription = goalDescription
        self.goalLikers = goalLikers
        self.goalTags = goalTags
        self.goalLikeCount = goalLikeCount
        self.goalTimeStamp = goalTimeStamp
        self.goalLastUpdated = goalLastUpdated
        self.goalAchieved = goalAchieved
        self.goalAmount = goalAmount
        self.goalDuration = goalDuration
        self.goalCurrentVal = goalCurrentVal
        self.goalStartAmount = goalStartAmount
        self.goalTargetVal = goalTargetVal
        self.goalAllowCommenting = goalAllowCommenting
        self.goalUndiscoverable = goalUndiscoverable
        self.goalHideFinancialInfo = goalHideFinancialInfo
        self.goalHidePieChart = goalHidePieChart
        self.goalAllowCopying = goalAllowCopying
        self.goalFunded = goalFunded
        self.goalImages = goalImages
        self.goalOriginalID = goalOriginalID
        self.goalOriginalCreator = goalOriginalCreator
        self.goalNumberPeopleCopied = goalNumberPeopleCopied
        
    }
}

