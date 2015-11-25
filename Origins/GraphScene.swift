//
//  GraphScene.swift
//  Origins
//
//  Created by Rohan Dhaimade on 11/3/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import UIKit
import SpriteKit

import Vectors

class GraphScene: SKScene {

    let player = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(100, 100))
    var repulsion : Double = 15.0
    var stiffness : Double = 10.0
    var damping : Double = 0.5

    var lastTimeInterval : NSTimeInterval?


    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0,0)

        var balls: [CircleNode] = [];
        for _ in 0...5 {
            let ball = CircleNode(circleOfRadius: 25)
            ball.position = CGPointMake(CGFloat(arc4random_uniform(100))+100.0, CGFloat(arc4random_uniform(100))+100.0)
            ball.setupNode()
            balls.append(ball)
            self.addChild(ball)
        }

        for i in 0..<balls.count-1 {
            let edgeNode = EdgeNode(node1: balls[i], node2: balls[i+1])
            self.addChild(edgeNode)
        }
    }

    override func update(currentTime: NSTimeInterval) {
        if (self.lastTimeInterval != nil) {
            if (currentTime-self.lastTimeInterval! < 2) {
                return;
            } else {
                self.lastTimeInterval = currentTime
            }
        } else {
            self.lastTimeInterval = currentTime;
            return;
        }

        let ballNodes:[CircleNode] = self.children.filter {$0.name == "CIRCLE"}.map{$0 as! CircleNode}
        let edgeNodes:[EdgeNode] = self.children.filter {$0.name == EdgeNode.nodeTypeName}.map{$0 as! EdgeNode}

        // Mark : Couloumb's law
        for node1 in ballNodes {
            for node2 in ballNodes {
                if (node1 != node2) {
                    let newPosition : Vector2D = node1.vectorPosition - node2.vectorPosition
                    let distance = newPosition.magnitude
                    let direction = newPosition.normalized

                    node1.acceleration = node1.acceleration + ((direction*repulsion)/(distance * distance * 0.5))
                    node2.acceleration = node2.acceleration + ((direction*repulsion)/(distance * distance * -0.5))
                }
            }
        }

        // Mark : Hook's Law
        for edgeNode in edgeNodes {
            let newDirection = edgeNode.node2.vectorPosition - edgeNode.node1.vectorPosition
            // TODO: This seems wrong, displacement is just too large. Springy is somehow able to do some math that I'm missing I believe.
            let displacement = max(min(50 - newDirection.magnitude, 50, 50), -50)
            let direction = newDirection.normalized

            edgeNode.node1.acceleration = edgeNode.node1.acceleration + (direction * stiffness * displacement * -0.5)
            edgeNode.node2.acceleration = edgeNode.node2.acceleration + (direction * stiffness * displacement * 0.5)
        }

       // Mark : Center Graviation
        // TODO: Something is wrong wit this, how do you figure out graviation to the center of the screen?
//        let screenWidth = UInt32(UIScreen.mainScreen().bounds.size.width)
//        let screenHeight = UInt32(UIScreen.mainScreen().bounds.size.height)
//        for node in ballNodes {
//            let direction = Vector2D(
//            node.acceleration = node.acceleration + (direction * (repulsion/50))
//        }


        // Mark : Update Positions after force calculations
        for node in ballNodes {
            node.velocity = node.velocity + node.acceleration*1*damping
            node.acceleration = Vector2D(0,0)
        }

        for node in ballNodes {
            node.vectorPosition = node.vectorPosition + node.velocity * 1
            node.position = CGPoint(x:node.vectorPosition.x, y: node.vectorPosition.y)
        }


        for edgeNode in edgeNodes {
            edgeNode.updateEdge()
        }
    }
}

public func /(value: Double, vector: Vector2D) -> Vector2D {
    return Vector2D((vector.x / value), (vector.y / value))
}

public func /(vector: Vector2D, value: Double) -> Vector2D {
    return value / vector
}