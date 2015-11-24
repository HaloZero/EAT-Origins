//
//  EdgeNode.swift
//  Origins
//
//  Created by Rohan on 11/24/15.
//  Copyright © 2015 Rohan. All rights reserved.
//

import Foundation
import SpriteKit

class EdgeNode : SKShapeNode {
    static let nodeTypeName = "EDGE"
    var node1: SKShapeNode
    var node2: SKShapeNode

    init(node1 : SKShapeNode, node2: SKShapeNode) {
        self.node1 = node1;
        self.node2 = node2
        super.init()

        self.name = EdgeNode.nodeTypeName
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }


    private func createLineBetweenEdges() -> CGMutablePath {
        let linePath = CGPathCreateMutable()
        CGPathMoveToPoint(linePath, nil, node1.position.x, node1.position.y)
        CGPathAddLineToPoint(linePath, nil, node2.position.x, node2.position.y)
        return linePath
    }

    func updateEdge() {
        if (self.path != nil) {
            self.path = nil
        }

        self.path = self.createLineBetweenEdges()
    }
}