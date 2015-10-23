//
//  ViewController.swift
//  Origins
//
//  Created by Rohan Dhaimade on 10/12/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import UIKit
import AlamofireImage

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    var friendships: [AnyObject] = [];

    override func viewDidLoad() {
        super.viewDidLoad()


        let filePath : String = NSBundle(forClass: ViewController.self).pathForResource("friendship", ofType: "json")!
        let data : NSData? = NSData(contentsOfFile: filePath)
        do {
            try self.friendships = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [AnyObject];
        } catch {
            print("Don't care")
        }

        self.tableView.registerNib(UINib.init(nibName: "FriendshipTableViewCell", bundle: nil), forCellReuseIdentifier: "FriendshipCell");

        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.estimatedRowHeight = 100;
        self.tableView.rowHeight = UITableViewAutomaticDimension;
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friendships.count;
    }

    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell : FriendshipTableViewCell =
        self.tableView.dequeueReusableCellWithIdentifier("FriendshipCell", forIndexPath: indexPath) as! FriendshipTableViewCell
        

        var friendShip: Dictionary<String, AnyObject> = self.friendships[indexPath.row] as! Dictionary<String, AnyObject>

        var originalFriend: Dictionary<String, AnyObject> = friendShip["original_friend"] as! Dictionary<String, AnyObject>
        var newFriend: Dictionary<String, AnyObject> = friendShip["new_friend"] as! Dictionary<String, AnyObject>
        cell.storyLabel.text = friendShip["story"] as? String;
        cell.friendshipConnection.af_setImageWithURL(NSURL(string: originalFriend["picture"] as! String)!);
        cell.newFriend.af_setImageWithURL(NSURL(string: newFriend["picture"] as! String)!);

        return cell;

    }
}

