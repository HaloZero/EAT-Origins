//
//  ProfileViewController.swift
//  Origins
//
//  Created by Rohan Dhaimade on 4/20/16.
//  Copyright © 2016 Rohan. All rights reserved.
//

import Foundation
import UIKit

import AlamofireImage

class ProfileViewController : UIViewController {

    let user: User
    var friendships: [User]?  {
        get {
            return DataManager.sharedInstance.friendsForUser(user)
        }
    }

    @IBOutlet weak var oldFriendName: UILabel!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var imageView: UIImageView!

    required init?(coder aDecoder: NSCoder) {
        self.user = User.fakeUser()
        super.init(coder: aDecoder)
    }

    init(user: User) {
        self.user = user
        super.init(nibName: "ProfileViewController", bundle: nil)
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        let roundedFilter = RoundedCornersFilter(radius: self.imageView.frame.size.height)

        self.oldFriendName.text = user.name
        self.imageView.af_setImageWithURL(user.profilePictureURL)
        self.imageView.af_setImageWithURL(user.profilePictureURL, filter: roundedFilter)

        self.closeButton.addTarget(self, action: #selector(ProfileViewController.close), forControlEvents: .TouchUpInside)
    }

    func close() {
        self.dismissViewControllerAnimated(true, completion: nil)
    }


}