//
//  ViewController.swift
//  Origins
//
//  Created by Rohan Dhaimade on 10/12/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import UIKit
import SwiftyJSON

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var friendships: [AnyObject] = [];

    override func viewDidLoad() {
        super.viewDidLoad()


        let filePath : String = NSBundle(forClass: ViewController.self).pathForResource("friendship", ofType: "json")!
        let data : NSData? = NSData(contentsOfFile: filePath)
        do {
            try self.friendships = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [AnyObject];
            self.friendships.sortInPlace({ (Object1, Object2) -> Bool in
                let friendship1: JSON = JSON(Object1)
                let friendship2:JSON  = JSON(Object2)
                return friendship1["new_friend"]["name"].stringValue < friendship2["new_friend"]["name"].stringValue
            })
        } catch {

            print("Don't care")
        }

        self.tableView.registerNib(UINib.init(nibName: "FriendshipTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendshipCell");

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendships.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : FriendshipTableViewCell =
        self.tableView.dequeueReusableCellWithIdentifier("FriendshipCell", forIndexPath: indexPath) as! FriendshipTableViewCell

        let friendship: JSON = JSON(self.friendships[indexPath.row])
        cell.configureFromFriendship(friendship);
        
        return cell;

    }
}

