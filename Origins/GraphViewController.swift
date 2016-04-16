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

    var scene: SKScene!

    override func viewDidLoad() {
        super.viewDidLoad()

        let skView = view as! SKView
        skView.showsFPS = true
        skView.showsNodeCount = true
        skView.ignoresSiblingOrder = true

        self.scene = GraphScene(size: skView.bounds.size)
        self.scene.scaleMode = .AspectFill

        skView.presentScene(self.scene)
    }

    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        self.scene.paused = true

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.scene.paused = false
    }

    override func preferredStatusBarStyle() -> UIStatusBarStyle {
        return UIStatusBarStyle.LightContent
    }


}
