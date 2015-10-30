//
//  FriendshipTableViewCell.swift
//  Origins
//
//  Created by Rohan Dhaimade on 10/12/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import Foundation
import UIKit

class FriendshipTableViewCell: UITableViewCell {

    @IBOutlet weak var friendshipConnection: UIImageView!
    @IBOutlet weak var storyLabel: UILabel!
    @IBOutlet weak var originalFriendName: UILabel!
    @IBOutlet weak var newFriend: UIImageView!
    @IBOutlet weak var linkLine: UIView!
    @IBOutlet weak var friendshipTypeImageView: UIImageView!
    @IBOutlet weak var newFriendName: UILabel!

    override func prepareForReuse() {
        super.prepareForReuse()
        self.friendshipTypeImageView.image = nil
        self.newFriend.image = nil
        self.friendshipConnection.image = nil

    }
}