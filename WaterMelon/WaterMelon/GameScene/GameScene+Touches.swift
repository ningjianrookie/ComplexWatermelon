//
//  GameScene+Touches.swift
//  WaterMelon
//
//  Created by 宁健 on 2021/9/24.
//

import SwiftUI
import SpriteKit
//MARK: - Touches
extension GameScene {
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else {return}
        let location = touch.location(in: self)
        
        if gameover {
            if atPoint(location) == restart {
                isShowRedline = false
                gameover = false
                score = 0
                groundFruit = []
                removeAllChildren()
                print(111)
                
                print(gameover)
                initGame()
            }
            return
        }
        
        nowFruit.run(.sequence([
            .moveTo(x: location.x, duration: 0.2),
            .run{
                self.nowFruit.physicsBody = SKPhysicsBody(circleOfRadius: self.nowFruit.size.width/2)
                
                let bitmask = self.fruitUtil.getFruitDataByName(fruitName: self.nowFruit.name!).bitmask
                self.nowFruit.physicsBody?.categoryBitMask = bitmask
                self.nowFruit.physicsBody?.contactTestBitMask = bitmask
            },
            .wait(forDuration: 0.5),
            .run {
                self.groundFruit.append(self.nowFruit)
                self.nowFruit = self.fruitUtil.randomFruit()
                self.addChild(self.nowFruit)
                self.nowFruit.setScale(0)
                self.nowFruit.run(.scale(to: 0.5, duration: 0.2))
            }
        ]))
        
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    
}
struct GameSceneTouches_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
