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
//        self.backgroundColor = SKColor.whiteColor()

        self.physicsWorld.gravity = CGVectorMake(0,0)

        let circleNode : SKShapeNode = SKShapeNode(circleOfRadius: 25)
        circleNode.fillColor = UIColor.greenColor()
        circleNode.physicsBody = SKPhysicsBody(circleOfRadius: 25)
        if let circlePhysics = circleNode.physicsBody {
            circlePhysics.dynamic = true
            circlePhysics.affectedByGravity = true
        }

        circleNode.position = CGPointMake(100, 400)
        self.addChild(circleNode)


        

//        self.player.position = CGPoint(x: size.width * 0.3, y: size.height * 0.5)
//
//        if let physics = player.physicsBody {
//            physics.dynamic = true
//            physics.affectedByGravity = true
//            physics.mass = 1.0
//        }
//
//        self.addChild(player)



    }
}
