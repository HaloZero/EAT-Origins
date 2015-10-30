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

    @IBOutlet weak var originalFriendImageView: UIImageView!
    @IBOutlet weak var originalFriendName: UILabel!

    @IBOutlet weak var friendshipTypeImageView: UIImageView!
    @IBOutlet weak var linkLine: UIView!

    @IBOutlet weak var newFriendImageView: UIImageView!
    @IBOutlet weak var newFriendName: UILabel!

    @IBOutlet weak var storyLabel: UILabel!


    override func prepareForReuse() {
        super.prepareForReuse()
        self.friendshipTypeImageView.image = nil
        self.newFriendImageView.image = nil
        self.originalFriendImageView.image = nil

    }
}