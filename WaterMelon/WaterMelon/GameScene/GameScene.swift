//
//  GameScene.swift
//  WaterMelon
//
//  Created by 宁健 on 2021/9/23.
//

import Foundation
import SpriteKit
import SwiftUI

class GameScene: SKScene,SKPhysicsContactDelegate{
    var nowFruit : SKSpriteNode!
    var nowScoreNode :SKSpriteNode!
    var groundFruit :[SKSpriteNode] = []
    var fruitUtil :FruitUtil!
    var score:Int = 0 {
        didSet{
            updateScore()
        }
    }
    var ground : SKSpriteNode!
    
    let falldownAudio = SoundUtil.init(resourceName: "falldown")
    let winAudio = SoundUtil.init(resourceName: "win")
    let bombAudio = SoundUtil.init(resourceName: "bomb")
    
    var redlineNode :SKSpriteNode!
    var isShowRedline = false
    
    var gameover = false
    var gameoverNode: SKSpriteNode!
    var restart: SKSpriteNode!
    
    func initGame() {
        fruitUtil = FruitUtil()
        makeUI()
        makeNowFruit()
        makeNowScoreNode()
        initRedline()
    }
    
    override func update(_ currentTime: TimeInterval) {
        if gameover { return }
        
        if isShowRedline {
            for fruit in groundFruit {
                if fruit.position.y > screen.height - 120 {
                    gameover = true
                    loadingGameover()
                    break
                }
            }
        }
        
        if isShowRedline {
            if !checkRedlineHeight() {
                showOutRedline()
                isShowRedline = false
            }
        }else{
            if checkRedlineHeight() {
                showInRedline()
                isShowRedline = true
            }
        }
            
        
    }
    func checkRedlineHeight() ->Bool{
        for fruit in groundFruit {
            if fruit.position.y > screen.height - 120 - 150 {
                return true
            }
        }
        return false
    }
}

struct GameScene_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
