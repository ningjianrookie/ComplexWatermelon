//
//  GameScene+Realine.swift
//  WaterMelon
//
//  Created by 宁健 on 2021/9/30.
//

import SwiftUI
import SpriteKit

extension GameScene {
    func initRedline() {
        redlineNode = SKSpriteNode(imageNamed: "redline")
        redlineNode.anchorPoint = CGPoint.zero
        redlineNode.position = CGPoint(x: 0, y: screen.height - 120)
        addChild(redlineNode)
        redlineNode.setScale(0)
        redlineNode.run(.repeat(.sequence([
            .fadeOut(withDuration: 0.5),
            .fadeIn(withDuration: 0.5)
        ]), count: -1))
    }
    
    func showInRedline() {
        redlineNode.setScale(1)
    }
    func showOutRedline(){
        redlineNode.setScale(0)
    }
}
struct GameSceneRedline_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
