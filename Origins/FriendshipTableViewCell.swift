//
//  FriendshipTableViewCell.swift
//  Origins
//
//  Created by Rohan Dhaimade on 10/12/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import Foundation
import UIKit

import AlamofireImage
import SwiftyJSON

class FriendshipTableViewCell: UITableViewCell {

    @IBOutlet weak var originalFriendImageView: UIImageView!
    @IBOutlet weak var originalFriendName: UILabel!

    @IBOutlet weak var friendshipTypeImageView: UIImageView!

    @IBOutlet weak var leftLinkLine: UIView!
    @IBOutlet weak var rightLinkLine: UIView!
    @IBOutlet weak var rightLinkLineWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var leftLinkLineWidthConstraint: NSLayoutConstraint!
    @IBOutlet weak var newFriendImageView: UIImageView!
    @IBOutlet weak var newFriendName: UILabel!

    @IBOutlet weak var storyLabel: UILabel!


    override func prepareForReuse() {
        super.prepareForReuse()
        self.friendshipTypeImageView.image = nil
        self.newFriendImageView.image = nil
        self.originalFriendImageView.image = nil
    }

    @IBOutlet weak var blah: NSLayoutConstraint!
    func configureFromFriendship(friendship: Friendship) {
        storyLabel.text = friendship.story

        let roundedFilter: ImageFilter = RoundedCornersFilter(radius: self.originalFriendImageView.frame.size.height);

        self.originalFriendImageView.af_setImageWithURL(
            friendship.oldFriend.profilePictureURL,
            placeholderImage: UIImage(named: "person-placeholder"),
            filter: roundedFilter
        )

        self.newFriendImageView.af_setImageWithURL(
            friendship.newFriend.profilePictureURL,
            placeholderImage: UIImage(named: "person-placeholder"),
            filter: roundedFilter
        )

        self.originalFriendName.text = friendship.oldFriend.name
        self.newFriendName.text = friendship.newFriend.name

        self.leftLinkLineWidthConstraint.constant = 0
        //        self.rightLinkLineWidthConstraint.constant = 0
        self.leftLinkLine.layoutIfNeeded()
//        UIView.animateWithDuration(1.5, animations: {
//            let newWidth = CGFloat(83)
//////            let newWidth = (self.rightLinkLine.frame.origin.x + self.rightLinkLine.frame.size.width - self.leftLinkLine.frame.origin.x)/2
//            self.leftLinkLineWidthConstraint.constant = newWidth
////            self.rightLinkLineWidthConstraint.constant = newWidth
//            self.leftLinkLine.layoutIfNeeded()
//        })

        if let image = friendship.friendshipType?.image() {
            self.friendshipTypeImageView.image = image
            self.friendshipTypeImageView.backgroundColor = UIColor.whiteColor();
        }


    }
}