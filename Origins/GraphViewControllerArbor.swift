//
//  GraphViewControllerArbor.swift
//  Origins
//
//  Created by Rohan on 11/25/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import Foundation
import UIKit

import SwiftyJSON

class GraphViewControllerArbor : UIViewController {

    @IBOutlet weak var canvas: AtlasCanvasView!

    var system : ATSystem!

    @IBOutlet weak var canvasHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var canvasWidthConstraint: NSLayoutConstraint!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.system = ATSystem()

        let params = self.system.parameters
        params.repulsion = 1000.0
        params.stiffness = 600.0
        params.friction  = 0.5
        params.precision = 0.4

        self.system.parameters = params

        // Setup the view bounds
        // view bounds are set up inside canvas view

        self.canvasHeightConstraint.constant = 1000
        self.canvasWidthConstraint.constant = 1000

        // leave some space at the bottom and top for text
        // TODO: Change this
        self.system.viewPadding = UIEdgeInsetsMake(20.0, 20.0, 20.0, 20.0);

        // have the ‘camera’ zoom somewhat slowly as the graph unfolds
        self.system.viewTweenStep = 0.2;

        // set this controller as the system's delegate
        self.system.delegate = self;

        // DEBUG
        self.canvas.system = self.system;
        self.canvas.debugDrawing = false;  // Do long press gesture to toggle.

        // load the map data
        self.loadFriendData()

        // start the simulation
        self.system.start(true)
    }

    func loadFriendData() {
        let filePath : String = NSBundle(forClass: ListViewController.self).pathForResource("friendship", ofType: "json")!
        let data : NSData? = NSData(contentsOfFile: filePath)

        var friendships: [AnyObject] = []

        do {
            try friendships = NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions(rawValue: 0)) as! [AnyObject];
            friendships.sortInPlace({ (Object1, Object2) -> Bool in
                let friendship1: JSON = JSON(Object1)
                let friendship2: JSON  = JSON(Object2)
                return friendship1["new_friend"]["name"].stringValue < friendship2["new_friend"]["name"].stringValue
            })
        } catch {
            print("Don't care")
        }

        var newFriendNames = friendships.map({ (friendship) -> String in
            var friendshipJSON = JSON(friendship)
            return friendshipJSON["new_friend"]["name"].stringValue
        })

        var originalFriendNames = friendships.map({ (friendship) -> String in
            var friendshipJSON = JSON(friendship)
            return friendshipJSON["original_friend"]["name"].stringValue
        })

        var nameSet : Set<String> = Set()
        for name in newFriendNames+originalFriendNames {
            nameSet.insert(name)
        }

        for name in nameSet {
            self.system.addNode(name, withData: nil)
        }

        for friendshipEdge in friendships[0...5] {
            let friendshipJSON = JSON(friendshipEdge)
            print(friendshipJSON)
            let newFriendName = friendshipJSON["new_friend"]["name"].stringValue
            let originalFriendName = friendshipJSON["original_friend"]["name"].stringValue

//            self.system.addEdgeFromNode(newFriendName, toNode: originalFriendName, withData: nil)
        }
    }
}