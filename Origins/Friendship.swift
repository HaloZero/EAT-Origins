//
//  Friendship.swift
//  Origins
//
//  Created by Rohan on 4/20/16.
//  Copyright © 2016 Rohan. All rights reserved.
//

import Foundation
import Decodable

enum FriendshipType : String {
    case College
    case Dodgeball
    case Family
    case Romantic
    case Sports
    case Friends
    case Work
    case Random
    case Party
    
    func image() -> UIImage? {
        switch self {
        case .College: return UIImage(named: "college")
        case .Romantic: return UIImage(named: "heart")
        case .Friends: return UIImage(named: "user")
        default: return nil
        }
    }
}

struct User {
    let name: String
    let profilePictureURL: NSURL
}

extension User : Decodable {
    static func decode(j: AnyObject) throws -> User {
        return try User(name: j => "name" as! String,
                        profilePictureURL: NSURL(string:j => "picture_url")!)

    }
}

struct Friendship {
    let oldFriend: User
    let newFriend: User
    let friendshipType: FriendshipType?
    let story: String
}

extension Friendship : Decodable {
    static func decode(j: AnyObject) throws -> Friendship {
        return try Friendship(
            oldFriend: j => "old_friend",
            newFriend: j => "new_friend",
            friendshipType: FriendshipType(rawValue: j => "type"),
            story: j => "story")

    }
}
