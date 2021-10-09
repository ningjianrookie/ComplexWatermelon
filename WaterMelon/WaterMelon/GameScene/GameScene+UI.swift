//
//  GameScene+UI.swift
//  WaterMelon
//
//  Created by 宁健 on 2021/9/24.
//

import SpriteKit
import SwiftUI

//MARK: - Load UI
extension GameScene{
    override func didMove(to view: SKView) {
        view.showsFPS = true
        view.showsNodeCount = true
        self.physicsWorld.contactDelegate = self
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        initGame()
        print("test==\(1<<3)")
    }
    
    func makeNowFruit(){
        nowFruit = fruitUtil.randomFruit()
        addChild(nowFruit)
    }
    func makeNowScoreNode(){
        nowScoreNode = SKSpriteNode()
        nowScoreNode.position = CGPoint(x: 35, y: screen.height - 80)
        nowScoreNode.setScale(0.5)
        addChild(nowScoreNode)
        updateScore()
    }
    
    func updateScore(){
        nowScoreNode.removeAllChildren()
        var scoreCopy = score
        var arr:[Int] = []
        if scoreCopy == 0 {
            arr.append(0)
        }else{
            while scoreCopy != 0 {
                arr.append(scoreCopy % 10)
                scoreCopy /= 10
            }
        }
        var cnt = 0
        while arr.count != 0 {
            let last = arr.popLast()!
            let node = SKSpriteNode(imageNamed: "number/\(last)")
//            node.anchorPoint = CGPoint.zero
            node.position = CGPoint(x: cnt * 50, y: 0)
            cnt += 1
            nowScoreNode .addChild(node)
        }
    }
    func makeUI (){
        let background = SKSpriteNode(color: UIColor(#colorLiteral(red: 0.9843137255, green: 0.9098039216, blue: 0.6509803922, alpha: 1)), size: CGSize(width: screen.width, height: screen.height))
        background.anchorPoint = CGPoint.zero
        background.position = CGPoint.zero
        addChild(background)
        
        let solid = SKSpriteNode(color: UIColor(#colorLiteral(red: 0.4588235294, green: 0.3333333333, blue: 0.2352941176, alpha: 1)), size: CGSize(width: screen.width, height: screen.height/5))
        solid.anchorPoint = CGPoint.zero
        solid.position = CGPoint.zero
        addChild(solid)
        
        ground = SKSpriteNode(color: UIColor(#colorLiteral(red: 0.6745098039, green: 0.537254902, blue: 0.3490196078, alpha: 1)), size: CGSize(width: screen.width, height: 10))
        ground.anchorPoint = CGPoint.zero
        ground.position = CGPoint(x: 0, y: screen.height/5)
        ground.physicsBody = SKPhysicsBody(edgeFrom: CGPoint(x: 0, y: ground.size.height), to: CGPoint(x: ground.size.width, y:ground.size.height ))
        ground.physicsBody?.categoryBitMask = 0xFFFFFFFF >> 1
        ground.physicsBody?.contactTestBitMask = 0xFFFFFFFF >> 1
        addChild(ground)
    }
    func loadingGameover() {
        gameoverNode = SKSpriteNode()
        gameoverNode.position = CGPoint(x: screen.width / 2, y: screen.height / 2)
        
        let gray = SKSpriteNode(color: UIColor(#colorLiteral(red: 0, green: 0, blue: 0, alpha: 0.4022575949)),
                                size: CGSize(width: screen.width,
                                             height: screen.height))
        let gameover = SKSpriteNode(imageNamed: "gameover")
        restart = SKSpriteNode(imageNamed: "restart")
        
        gameover.position = CGPoint(x: 0, y: 20)
        restart.position = CGPoint(x: 0, y: -20)
        
        gameoverNode.addChild(gray)
        gameoverNode.addChild(gameover)
        gameoverNode.addChild(restart)
        
        gameover.setScale(0.3)
        restart.setScale(0.3)
        addChild(gameoverNode)
    }
}
struct GameSceneUI_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

