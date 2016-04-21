//
//  ViewController.swift
//  Origins
//
//  Created by Rohan Dhaimade on 10/12/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ListViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UISearchControllerDelegate, UISearchResultsUpdating {

    @IBOutlet weak var tableView: UITableView!

    var friendships: [Friendship] = []
    var fullFriendshipList: [Friendship] = []
    var searchController: UISearchController? = nil;

    override func viewDidLoad() {
        super.viewDidLoad()

        let filePath : String = NSBundle(forClass: ListViewController.self).pathForResource("friendship", ofType: "json")!
        let data : NSData? = NSData(contentsOfFile: filePath)
        do {
            let json = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [AnyObject];
            self.friendships = try [Friendship].decode(json)
            self.fullFriendshipList = self.friendships;
        } catch {
            print("Don't care")
        }

        self.tableView.registerNib(UINib.init(nibName: "FriendshipTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendshipCell");

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;

        // TODO: This pattern sucks, how do I avoid that initialization method?
        // I don't want to have to do a! on this call to make sure there's a local variable that I don't have to do ! for, but I also don't want to initialize this in the self class.        
        self.searchController = UISearchController(searchResultsController: nil)

        let searchController = self.searchController!
        searchController.searchResultsUpdater = self;
        searchController.dimsBackgroundDuringPresentation = false;

        self.tableView.tableHeaderView = searchController.searchBar;
        self.definesPresentationContext = true;
    }

    func updateSearchResultsForSearchController(searchController: UISearchController) {
        if (searchController.searchBar.text == nil || searchController.searchBar.text!.isEmpty) {
//            self.friendships = self.fullFriendshipList;
        } else {
//            self.friendships = self.fullFriendshipList.filter({ (friendship: AnyObject) -> Bool in
//                let newFriendName : String = JSON(friendship)["new_friend"]["name"].stringValue
//                let originalFriendName : String = JSON(friendship)["original_friend"]["name"].stringValue
//                return newFriendName.containsString(searchController.searchBar.text!) || originalFriendName.containsString(searchController.searchBar.text!)
//            })
        }
        self.tableView.reloadData()
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendships.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : FriendshipTableViewCell =
        self.tableView.dequeueReusableCellWithIdentifier("FriendshipCell", forIndexPath: indexPath) as! FriendshipTableViewCell

        cell.configureFromFriendship(self.friendships[indexPath.row]);

        return cell;

    }
}

