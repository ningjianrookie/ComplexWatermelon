//
//  GameScene+Collisions.swift
//  WaterMelon
//
//  Created by 宁健 on 2021/9/28.
//

import SwiftUI
import SpriteKit

// MARK:- Collisions
var isGroundCollision:Bool = false

extension GameScene{
    func didBegin(_ contact: SKPhysicsContact) {
        
        let collision = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        //Ground Collision
        for fruit in FruitData.allCases{
            if isGroundCollision {return}
            let bit = fruit.bitmask | ground.physicsBody!.categoryBitMask
            if bit == collision {
                falldownAudio.playAudio()
                isGroundCollision = true
                Timer(timeInterval: 1, repeats: false) { _ in
                    isGroundCollision = false
                }.fire()
                break
            }
            
        }
        //Fruit Collision
        for fruit in FruitData.allCases{
            let fruitbit = fruit.bitmask | fruit.bitmask
            if fruitbit == collision {
                bombAudio.playAudio()
                
                let bodyA = contact.bodyA.node!
                let bodyB = contact.bodyB.node!
                if bodyA.name == FruitData.watermelon.name {
                    return
                }
                let score = fruitUtil.updateScoreWithName(furitName: bodyA.name!)
                self.score += score
                if bodyA.name == FruitData.halfwatermelon.name {
                    winAudio.playAudio()
                    showBouns()
                    self.score += 100
                }
                
                let newFruitPosition = CGPoint(x: (bodyA.position.x + bodyB.position.x)/2, y: (bodyA.position.y + bodyB.position.y)/2)
                
                run(.sequence([
                    .run({
                        bodyA.run(.fadeOut(withDuration: 0.1))
                        bodyB.run(.fadeOut(withDuration: 0.1))
                    }),
                    .run({
                        bodyA .removeFromParent()
                        bodyB .removeFromParent()
                    }),
                    .run({
                        self.compositonNewFruitWihtPosiontion(fruitName:bodyA.name!, posiont: newFruitPosition)
                    })
                ]))
                
                
            }
        }
    }
    func compositonNewFruitWihtPosiontion(fruitName:String, posiont:CGPoint) {
        let fruit = fruitUtil.mixFruit(fruitName: fruitName)
        fruit.position = posiont
        fruit.physicsBody = SKPhysicsBody(circleOfRadius: fruit.size.width/2)
        let bitmask = fruitUtil.getFruitDataByName(fruitName: fruit.name!).bitmask
        fruit.physicsBody?.categoryBitMask = bitmask
        fruit.physicsBody?.contactTestBitMask = bitmask
        
        addChild(fruit)
        fruit.setScale(0)
        fruit.run(.scale(to: 0.5, duration: 0.2))
        
        groundFruit.append(fruit)
    }
    func showBouns() {
        let bounsNode = SKSpriteNode()
        let gray = SKSpriteNode(color: #colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.5), size: CGSize(width: screen.width, height: screen.height))
        gray.position = CGPoint(x: screen.width/2, y: screen.height/2)
        
        let layer = SKSpriteNode()
        
        let yellowLight = SKSpriteNode(imageNamed: "yellowlight")
        
        let watermelon = SKSpriteNode(imageNamed: FruitData.watermelon.name)
        watermelon.setScale(0.3)
        
        layer .addChild(yellowLight)
        layer.addChild(watermelon)
        gray .addChild(layer)
        bounsNode.addChild(gray)
        addChild(bounsNode)
        
        layer.setScale(0.1)
        layer.position = CGPoint(x: 0, y: 50)
        layer.run(.sequence([
            .scale(to: 1, duration: 0.8),
            .wait(forDuration: 1),
            .scale(to: 0, duration: 0.5)
        ]))
        layer.run(.sequence([
            .moveTo(y: 150, duration: 0.3),
            .moveTo(y: 0, duration: 0.5),
            .wait(forDuration: 1),
            .moveTo(y: 400, duration: 0.5),
            .run({
                bounsNode.run(.fadeOut(withDuration: 0.5))
                bounsNode .removeFromParent()
            })
        ]))
        
        
    }
    func didEnd(_ contact: SKPhysicsContact) {
        
    }
}
struct GameSceneCollisions_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
