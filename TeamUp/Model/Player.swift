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
        
        
        
        guard let dict = snapshot.value as?  [String: AnyObject] else { return nil }
        
        print("convert data to object ",dict)
        print("player name is", dict["name"] as! String)


        guard let uid  = dict[PlayerUid]  else { return nil }
        guard let name = dict[PlayerName] else { return nil }
        guard let age = dict[PlayerAge] else { return nil }
        guard let image = dict[PlayerAvatarUrl] else { return nil }
        guard let phoneNumber = dict[PlayerPhoneNumber] else { return nil }
        
        guard let work = dict[PlayerWork] else { return nil }
        guard let location = dict[PlayerLocation] else { return nil }
        guard let positionPlay = dict[PlayerPlayPosition] else { return nil }
        guard let favoriteClub = dict[PlayerFavoriteClub] else { return nil }
        
        guard let spareTime = dict[PlayerSpareTime] else { return nil }
        guard let matchJoin = dict[PlayerMatchJoin] else { return nil }
        guard let hobby = dict[PlayerHobby] else { return nil }

        guard let height = dict[PlayerHeight] else { return nil }
        guard let weight = dict[PlayerWeight] else { return nil }
        guard let comment = dict[PlayerComment] else { return nil }
        
        guard let teamJoined = dict[PlayerTeamJoined] else { return nil }
        guard let joinStatus = dict[PlayerJoinStatus] else { return nil }

        
        self.uid = uid as! String
        
        self.name = name as! String
        
        
        
        self.age = age as! String
        self.phoneNumber = phoneNumber as! String
        self.image = image as! String
        
        self.work = work as! String
        self.location = location as! String
        self.positionPlay = positionPlay as! String
        self.favoriteClub = favoriteClub as! String
        self.spareTime = spareTime as! String
        self.matchJoin = matchJoin as AnyObject
        self.hobby = hobby as! String
        self.height = height as! String
        self.weight = weight as! String
        self.comment = comment as! String
        self.teamJoined = teamJoined as AnyObject
        self.joinStatus = joinStatus as! String

    }
    
    convenience override init() {
        self.init(uid: "", name: "", age: "", image: "", phoneNumber: "", work: "", location: "", positionPlay: "", favoriteClub: "", spareTime: "", matchJoin: "" as AnyObject, hobby: "", height: "", weight: "", comment: "", teamJoined: "" as AnyObject, joinStatus: "")
    }

}













