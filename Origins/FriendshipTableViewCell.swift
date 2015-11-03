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

    func configureFromFriendship(friendship: JSON) {
        let originalFriend: JSON = JSON(friendship["original_friend"].dictionaryValue)
        let newFriend: JSON = JSON(friendship["new_friend"].dictionaryValue)
        self.storyLabel.text = friendship["story"].stringValue

        let roundedFilter: ImageFilter = RoundedCornersFilter(radius: self.originalFriendImageView.frame.size.height);

        self.originalFriendImageView.af_setImageWithURL(NSURL(string: originalFriend["picture"].stringValue)!, filter: roundedFilter)
        self.newFriendImageView.af_setImageWithURL(NSURL(string: newFriend["picture"].stringValue)!, placeholderImage: nil, filter: roundedFilter)

        self.originalFriendName.text = originalFriend["name"].string;
        self.newFriendName.text = newFriend["name"].string;
        self.linkLine.backgroundColor = UIColor.greenColor();
        self.friendshipTypeImageView.image = UIImage(named: friendship["type"].stringValue.lowercaseString);
        if (self.friendshipTypeImageView.image != nil) {
            self.friendshipTypeImageView.backgroundColor = UIColor.whiteColor();
        }

    }
}