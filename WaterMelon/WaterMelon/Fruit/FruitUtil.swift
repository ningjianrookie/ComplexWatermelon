//
//  Fruit.swift
//  WaterMelon
//
//  Created by 宁健 on 2021/9/24.
//

import Foundation
import SpriteKit
class FruitUtil {
    private let randomList = [
        FruitData.grape,
        FruitData.cherry,
        FruitData.orange,
        FruitData.lemon,
        FruitData.kiwi
    ]
    private let mixList = [
        FruitData.grape,
        FruitData.cherry,
        FruitData.orange,
        FruitData.lemon,
        FruitData.kiwi,
        FruitData.tomato,
        FruitData.peach,
        FruitData.pineaple,
        FruitData.cocount,
        FruitData.halfwatermelon,
        FruitData.watermelon
    ]
    private var nowCount = 0
    func randomFruit()-> SKSpriteNode{
        var name:String
        nowCount += 1
        switch nowCount {
        case 1...3:
            name = FruitData.grape.name
        case 4:
            name = FruitData.cherry.name
        case 5:
            name = FruitData.lemon.name
        default:
            name = randomList.randomElement()!.name
        }
        let fruit = SKSpriteNode(imageNamed: name)
        fruit.position = CGPoint(x: screen.width/2, y: screen.height - 90)
        fruit.setScale(0.5)
        fruit.name = name
        return fruit
    }
    func mixFruit(fruitName:String)-> SKSpriteNode{
        let index = mixList.firstIndex{fruitName == $0.name}
        if index==nil || index! == mixList.count - 1{
            print("FATAL ERRO:FRUIT NAME NOT FOUND")
        }
        let fruit = SKSpriteNode(imageNamed: mixList[index! + 1].name)
        fruit.name = mixList[index! + 1].name
        return fruit
    }
    func getFruitDataByName(fruitName:String) -> FruitData{
        FruitData.allCases.first{ $0.name == fruitName}!
    }
    func updateScoreWithName(furitName:String) ->Int {
        mixList.firstIndex{ $0.name == furitName}! + 1
    }
}
