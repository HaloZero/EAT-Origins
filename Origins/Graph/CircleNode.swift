//
//  CircleNode.swift
//  Origins
//
//  Created by Rohan on 11/24/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import Foundation
import SpriteKit

import Vectors

class CircleNode : SKShapeNode {

    var velocity : Vector2D!
    var acceleration: Vector2D!
    var mass : NSInteger = 1
    var vectorPosition : Vector2D!

    // TODO: Setup node with position
    func setupNode() {
        self.vectorPosition = Vector2D(Double(self.position.x), Double(self.position.y))
        self.velocity = Vector2D(0, 0)
        self.acceleration = Vector2D(0, 0)
        self.name = "CIRCLE"
        self.fillColor = [UIColor.greenColor(), UIColor.redColor(), UIColor.blueColor()][Int(arc4random_uniform(UInt32(3)))]
        self.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        if let circlePhysics = self.physicsBody {
            circlePhysics.dynamic = true
            circlePhysics.affectedByGravity = false
        }
    }

    func updateNode() {
        
    }
}