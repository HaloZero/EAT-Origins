//
//  GraphScene.swift
//  Origins
//
//  Created by Rohan Dhaimade on 11/3/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import UIKit
import SpriteKit

class GraphScene: SKScene {

    let player = SKSpriteNode(color: UIColor.greenColor(), size: CGSizeMake(100, 100))

    override func didMoveToView(view: SKView) {
        self.physicsWorld.gravity = CGVectorMake(0,0)

        let ball1 = self.createCircle("Ball1")
        ball1.position = CGPointMake(100, 400)
        self.addChild(ball1)

        let ball2 = self.createCircle("Ball2")
        ball2.position = CGPointMake(200, 350)
        self.addChild(ball2)

        let lineNode = EdgeNode(node1: ball1, node2: ball2)

        self.addChild(lineNode)
    }

    func createLineBetweenNode(node1: SKShapeNode, node2: SKShapeNode) -> CGMutablePath {
        let linePath = CGPathCreateMutable()
        CGPathMoveToPoint(linePath, nil, node1.position.x, node1.position.y)
        CGPathAddLineToPoint(linePath, nil, node2.position.x, node2.position.y)
        return linePath
    }

    func createCircle(name: String) -> SKShapeNode {
        let circleNode : SKShapeNode = SKShapeNode(circleOfRadius: 25)
        circleNode.name = name
        circleNode.fillColor = [UIColor.greenColor(), UIColor.redColor(), UIColor.blueColor()][Int(arc4random_uniform(UInt32(3)))]
        circleNode.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        if let circlePhysics = circleNode.physicsBody {
            circlePhysics.dynamic = true
            circlePhysics.affectedByGravity = true
        }
        return circleNode
    }

    override func update(currentTime: NSTimeInterval) {
        let lineNode : EdgeNode? = self.childNodeWithName("EDGE") as? EdgeNode
        if let lineNode = lineNode {
            lineNode.updateEdge()
        }
    }
}
