//
//  Player.swift
//  TeamUp
//
//  Created by Hung_mobilefolk on 5/25/17.
//  Copyright © 2017 Macbook Pro. All rights reserved.
//

import UIKit
import Firebase

class Player: NSObject {
    var uid: String
    var name: String
    var age: String
    var image: String
    var phoneNumber: String
    var work: String
    var location: String
    var positionPlay: String
    var favoriteClub: String
    var spareTime: String
    var matchJoin: AnyObject?
    var hobby: String
    var height: String
    var weight: String
    var comment: String
    var teamJoined: AnyObject?
    var joinStatus: String
    
    var starCount: AnyObject?
    var stars: Dictionary<String, Bool>?
    
    init(uid: String, name: String, age: String, image: String,phoneNumber: String, work: String, location: String, positionPlay: String, favoriteClub: String, spareTime: String, matchJoin: AnyObject, hobby: String, height: String, weight: String, comment: String, teamJoined: AnyObject, joinStatus: String) {
        self.uid = uid
        self.name = name
        self.age = age
        self.image = image
        self.phoneNumber = phoneNumber
        self.work = work
        self.location = location
        self.positionPlay = positionPlay
        self.favoriteClub = favoriteClub
        self.spareTime = spareTime
        self.matchJoin = matchJoin
        self.hobby = hobby
        self.height = height
        self.weight = weight
        self.comment = comment
        self.teamJoined = teamJoined
        self.joinStatus = joinStatus
        
    }
    
    init?(snapshot: DataSnapshot) {
        guard let dict = snapshot.value as? [String: String] else { return nil }
        guard let uid  = dict["uid"]  else { return nil }
        guard let name = dict["name"] else { return nil }
        guard let age = dict["age"] else { return nil }
        guard let image = dict["image"] else { return nil }
        guard let phoneNumber = dict["phoneNumber"] else { return nil }
        
        guard let work = dict["work"] else { return nil }
        guard let location = dict["location"] else { return nil }
        guard let positionPlay = dict["positionPlay"] else { return nil }
        guard let favoriteClub = dict["favoriteClub"] else { return nil }
        
        guard let spareTime = dict["spareTime"] else { return nil }
        guard let matchJoin = dict["matchJoin"] else { return nil }
        guard let hobby = dict["hobby"] else { return nil }

        guard let height = dict["height"] else { return nil }
        guard let weight = dict["weight"] else { return nil }
        guard let comment = dict["comment"] else { return nil }
        
        guard let teamJoined = dict["teamJoined"] else { return nil }
        guard let joinStatus = dict["joinStatus"] else { return nil }

        
        self.uid = uid
        self.name = name
        self.age = age
        self.phoneNumber = phoneNumber
        self.image = image
        
        self.work = work
        self.location = location
        self.positionPlay = positionPlay
        self.favoriteClub = favoriteClub
        self.spareTime = spareTime
        self.matchJoin = matchJoin as AnyObject
        self.hobby = hobby
        self.height = height
        self.weight = weight
        self.comment = comment
        self.teamJoined = teamJoined as AnyObject
        self.joinStatus = joinStatus

    }
    
    convenience override init() {
        self.init(uid: "", name: "", age: "", image: "", phoneNumber: "", work: "", location: "", positionPlay: "", favoriteClub: "", spareTime: "", matchJoin: "" as AnyObject, hobby: "", height: "", weight: "", comment: "", teamJoined: "" as AnyObject, joinStatus: "")
    }

}













