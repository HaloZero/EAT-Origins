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

        let filePath : String = NSBundle(forClass: ListViewController.self).pathForResource("friendship", ofType: "json")!
        let data : NSData? = NSData(contentsOfFile: filePath)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [AnyObject];
            self.friendships = try [Friendship].decode(json)
            self.fullFriendshipList = self.friendships;
        } catch {
            print(error)
        }

        self.tableView.registerNib(UINib.init(nibName: "FriendshipTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendshipCell");

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100
        self.tableView.rowHeight = UITableViewAutomaticDimension

        self.tableView.tableHeaderView = searchController.searchBar;
        self.definesPresentationContext = true;
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

        return cell;
        
    }
}

extension ListViewController : UISearchControllerDelegate, UISearchResultsUpdating {
    var searchController: UISearchController {
        get {
            let searchController = UISearchController(searchResultsController: nil)
            searchController.searchResultsUpdater = self;
            searchController.dimsBackgroundDuringPresentation = false;
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
