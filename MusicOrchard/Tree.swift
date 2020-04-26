//
//  Tree.swift
//  MusicOrchard
//
//  Created by Chenxin Zhu on 4/19/20.
//  Copyright © 2020 Benjamin Blomquist. All rights reserved.
//

import Foundation
import SpriteKit

class Tree {
    var filename: String
    var node: SKSpriteNode
    var fruits: [Fruit]
    var width: Double
    var height: Double
    var xPosition: Double
    var yPosition: Double
    
    init(filename: String) {
        node = SKSpriteNode(imageNamed: filename)
        self.filename = filename
        fruits = []
        width = 0
        height = 0
        xPosition = 0
        yPosition = 0
    }
    
    init(filename: String, width: Double, height: Double, xPosition: Double, yPosition: Double) {
        node = SKSpriteNode(imageNamed: filename)
        self.filename = filename
        fruits = []
        self.width = 0
        self.height = 0
        self.xPosition = 0
        self.yPosition = 0
        setSize(width: width, height: height)
        setPosition(xPosition: xPosition, yPosition: yPosition)
    }
    
    func addFruit(fruit: Fruit, width: Double, height: Double, xPosition: Double, yPosition: Double) {
        fruit.setSize(width: width, height: height)
        fruit.setPosition(xPosition: xPosition, yPosition: yPosition)
        fruit.getNode().zPosition = getNode().zPosition + 1
        node.addChild(fruit.getNode())
        fruits.append(fruit)
    }
    
    func setSize(width: Double, height: Double) {
        node.scale(to: CGSize(width: width, height: height))
        self.width = width
        self.height = height
    }
    
    func setPosition(xPosition: Double, yPosition: Double) {
        self.xPosition = xPosition
        self.yPosition = yPosition
        node.position = CGPoint(x: xPosition, y: yPosition)
    }

    func getNode() -> SKSpriteNode {
        return node
    }
    
    func getSize() -> (Double, Double){
        return (width, height)
    }
    
    func getPosition() -> (Double, Double){
        return (xPosition, yPosition)
    }
    
}
