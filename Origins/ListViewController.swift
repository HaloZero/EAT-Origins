//
//  ViewController.swift
//  Origins
//
//  Created by Rohan Dhaimade on 10/12/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    var friendships: [Friendship] = []
    var fullFriendshipList: [Friendship] = []

    override func viewDidLoad() {
        super.viewDidLoad()

        self.friendships = DataManager.sharedInstance.friendships
        self.fullFriendshipList = self.friendships

        self.tableView.registerNib(UINib.init(nibName: "FriendshipTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendshipCell");

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension

        self.tableView.reloadData()

        self.tableView.tableHeaderView = searchController.searchBar
        self.definesPresentationContext = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        self.tableView.reloadData()
    }
}

extension ListViewController : UITableViewDelegate, UITableViewDataSource {

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendships.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : FriendshipTableViewCell =
            self.tableView.dequeueReusableCellWithIdentifier("FriendshipCell", forIndexPath: indexPath) as! FriendshipTableViewCell

        cell.configureFromFriendship(self.friendships[indexPath.row])

        cell.friendshipTypeImageView.alpha = 0.0

        cell.contentView.layoutIfNeeded()

        UIView.animateWithDuration(
            1.5,
            animations: {
                cell.leftLinkLineWidthConstraint.constant = 100
                cell.rightLinkLineWidthConstraint.constant = 100
                cell.contentView.layoutIfNeeded()
            },
            completion: { _ in
                UIView.animateWithDuration(0.25, animations: {
                    cell.friendshipTypeImageView.alpha = 1.0
                })
            }
        )

        return cell;
    }

    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let user = self.friendships[indexPath.row].newFriend
        let profileViewController = ProfileViewController(user: user)
        self.presentViewController(profileViewController, animated: true, completion: nil)
    }

    func tableView(tableView: UITableView, willDisplayCell cell: UITableViewCell, forRowAtIndexPath indexPath: NSIndexPath) {
        let cell : FriendshipTableViewCell =
            self.tableView.dequeueReusableCellWithIdentifier("FriendshipCell", forIndexPath: indexPath) as! FriendshipTableViewCell

    }
}

extension ListViewController : UISearchControllerDelegate, UISearchResultsUpdating {
    var searchController: UISearchController {
        get {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self
            searchController.dimsBackgroundDuringPresentation = false
            searchController.searchBar.backgroundColor = UIColor.lightGrayColor()
            return searchController
        }
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if (searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty) {
            self.friendships = self.fullFriendshipList;
        } else {
            self.friendships = self.fullFriendshipList.filter({ (friendship: Friendship) -> Bool in
                let newFriendName = friendship.newFriend.name
                let originalFriendName = friendship.oldFriend.name
                return newFriendName.containsString(searchController.searchBar.text!) || originalFriendName.containsString(searchController.searchBar.text!)
            })
        }
        self.tableView.reloadData()
    }
}
