//
//  GraphViewController.swift
//  Origins
//
//  Created by Rohan Dhaimade on 11/3/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import UIKit
import SpriteKit

class GraphViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true

        let scene = GraphScene(size: skView.bounds.size)
        scene.scaleMode = .AspectFill

        skView.presentScene(scene)

        self.tabBarController!.tabBar.hidden = true
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
    }



}
