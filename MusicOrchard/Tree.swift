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
    var width: Double
    var height: Double
    var xPosition: Double
    var yPosition: Double
    let treeSpots: [Spot] = [
        Spot(position: CGPoint(x: -300, y: 100), occupied: false),
        Spot(position: CGPoint(x: -200, y: -50), occupied: false),
        Spot(position: CGPoint(x: -75, y: 0), occupied: false),
        Spot(position: CGPoint(x: 150, y: -50), occupied: false),
        Spot(position: CGPoint(x: 300, y: 25), occupied: false),
        Spot(position: CGPoint(x: 0, y: 150), occupied: false)]
    
    init(filename: String) {
        node = SKSpriteNode(imageNamed: filename)
        self.filename = filename
        self.width = 0
        self.height = 0
        self.xPosition = 0
        self.yPosition = 0
        setSize(width: width, height: height)
        setPosition(xPosition: xPosition, yPosition: yPosition)
    }
    
    func grow(fruit: Fruit) {
        while true {
            let number = Int.random(in: treeSpots.indices)
            if !treeSpots[number].occupied {
                if (number % 2 == 0) {
                    fruit.run(SKAction.colorize(with: UIColor.gray, colorBlendFactor: 0.1, duration: 0.1))
                    fruit.tree = self
                    fruit.spot = treeSpots[number]
                    treeSpots[number].fruit = fruit
                    treeSpots[number].occupied = true
                    let position = treeSpots[number].position
                    fruit.setPosition(xPosition: Double(position.x), yPosition: Double(position.y))
                    node.addChild(fruit)
                    break
                }
                fruit.tree = self
                fruit.spot = treeSpots[number]
                treeSpots[number].fruit = fruit
                treeSpots[number].occupied = true
                let position = treeSpots[number].position
                fruit.setPosition(xPosition: Double(position.x), yPosition: Double(position.y))
                node.addChild(fruit)
                break
            }
        }
        fruit.zPosition = node.zPosition + 1000
        fruit.grow()
    }
    
    func deleteFruit(fruit: Fruit) {
        fruit.removeFromParent()
        fruit.alpha = 1.0
        fruit.spot?.occupied = false
        fruit.spot?.fruit = nil
        fruit.spot = nil
        fruit.tree = nil
        node.run(SKAction.wait(forDuration: 3)) {
            self.grow(fruit: fruit)
        }
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
}

class Spot {
    var fruit: Fruit? = nil
    var position: CGPoint
    var occupied: Bool
    
    init(position: CGPoint, occupied: Bool) {
        self.position = position
        self.occupied = occupied
    }
}
