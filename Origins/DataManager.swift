//
//  DataManager.swift
//  Origins
//
//  Created by Rohan on 4/21/16.
//  Copyright © 2016 Rohan. All rights reserved.
//

import Foundation

class DataManager {

    static let sharedInstance = DataManager()

    var friendships: [Friendship] {
        get {
            return self.friends()
        }
    }

    private func friends() -> [Friendship] {
        var friendships : [Friendship] = []
        let filePath : String = NSBundle(forClass: ListViewController.self).pathForResource("friendship", ofType: "json")!
        let data : NSData? = NSData(contentsOfFile: filePath)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [AnyObject];
            friendships = try [Friendship].decode(json)
        } catch {
            print(error)
        }

        return friendships
    }

    func friendsForUser(user: User) -> [User] {
        var friends: [User] = []
        for friendship in friendships {
            if friendship.oldFriend.name == user.name  {
                friends.append(friendship.newFriend)
            }
        }
        return friends
    }
}