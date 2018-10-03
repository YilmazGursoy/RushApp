//
//  User.swift
//  RushApp
//
//  Created by Yilmaz Gursoy on 2.09.2018.
//  Copyright © 2018 MW. All rights reserved.
//

import Foundation

struct User : Decodable {
    var userId:String
    var username:String
    var gameList:[Game]?
    var firebaseToken:String?
    var profileUrls:[SocialURL]?
    var followers:[SimpleUser]?
    var following:[SimpleUser]?
    var likeFeeds:[SimpleFeed]?
    var email:String?
    var phoneNumber:String?
    var fullName:String?
    var bio:String?
    var gender:String?
    var age:Int?
    
    enum CodingKeys: String, CodingKey {
        case userId = "userId"
        case username = "username"
        case gameList = "selectingGameIDs"
        case firebaseToken = "firebaseToken"
        case profileUrls = "profileUrls"
        case followers  = "followers"
        case following = "following"
        case likeFeeds = "likeFeeds"
        case email = "email"
        case phoneNumber = "phoneNumber"
        case fullName = "fullName"
        case bio = "bio"
        case gender = "gender"
        case age = "age"
    }
}

extension User {
    func getProfilePictureURL()->URL {
        let imageSpesificURL = userId + "/" + ConstantUrls.profilePictureName
        let imageUrl = imageSpesificURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = ConstantUrls.profilePictureS3BaseUrl + imageUrl!
        return URL(string: url)!
    }
    
    static func getProfilePictureFrom(userId:String) -> URL {
        let imageSpesificURL = userId + "/" + ConstantUrls.profilePictureName
        let imageUrl = imageSpesificURL.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed)
        let url = ConstantUrls.profilePictureS3BaseUrl + imageUrl!
        return URL(string: url)!
    }
}

