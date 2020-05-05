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
    let treeSpots: [Int : Spot] = [
        1 : Spot(position: CGPoint(x: -450, y: -75), occupied: false),
        2 : Spot(position: CGPoint(x: -250, y: -75), occupied: false),
        3 : Spot(position: CGPoint(x: -50, y: -75), occupied: false),
        4 : Spot(position: CGPoint(x: 150, y: -75), occupied: false),
        5 : Spot(position: CGPoint(x: 350, y: -75), occupied: false)]
    var fruits: [Fruit]
    var touches: [Int]
    
    init(filename: String) {
        node = SKSpriteNode(imageNamed: filename)
        self.filename = filename
        fruits = []
        self.width = 0
        self.height = 0
        self.xPosition = 0
        self.yPosition = 0
        touches = []
        setSize(width: width, height: height)
        setPosition(xPosition: xPosition, yPosition: yPosition)
    }
    
    func addFruit(fruit: Fruit) {
        putFruitIntoDict(fruit: fruit)
        setFruitSpot(fruit: fruit)
    }
    
    func putFruitIntoDict(fruit: Fruit) {
        fruit.setSize(width: 1000, height: 750)
        fruit.node.zPosition = node.zPosition + 1
        fruits.append(fruit)
    }
    
    func setFruitSpot(fruit: Fruit) {
        var number = Int.random(in: 1...5)
        var set = false
        while !set {
            if treeSpots[number]!.occupied {
                number = Int.random(in: 1...5)
            }
            else {
                fruit.spot = treeSpots[number]
                treeSpots[number]?.fruit = fruit
                treeSpots[number]?.occupied = true
                let position = treeSpots[number]?.position
                fruit.setPosition(xPosition: Double(position!.x), yPosition: Double(position!.y))
                node.addChild(fruit.node)
                set = true
            }
        }
    }
    
    func deleteFruit(fruit: Fruit) {
        node.removeChildren(in: [fruit.node])
        fruit.spot?.occupied = false
        fruit.spot?.fruit = nil
        fruit.spot = nil
        setFruitSpot(fruit: fruit)
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
