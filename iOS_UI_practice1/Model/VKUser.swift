//
//  VKFriend.swift
//  iOS_UI_practice1
//
//  Created by Alex on 16/01/2020.
//  Copyright © 2020 Alexey Kuznetsov. All rights reserved.
//

import Foundation

struct VKUser: Decodable {
    var id: Int
    var firstName: String
    var lastName: String
    var avatarPath: String
    var deactivated: String?
    var isOnline: Int?
    
    enum CodingKeys: String, CodingKey {
        case id
        case firstName = "first_name"
        case lastName = "last_name"
        case avatarPath = "photo_100"
        case deactivated
        case isOnline = "online"
    }
}

struct FriendsArray: Decodable {
    var count: Int
    var items: [VKUser]
}

struct ResponseFriends: Decodable {
    var response: FriendsArray
}
