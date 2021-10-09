//
//  SoundUtil.swift
//  WaterMelon
//
//  Created by 宁健 on 2021/9/29.
//

import Foundation
import AVFoundation

class SoundUtil {
    var resourceName:String
    var player : AVAudioPlayer!
    
    var isPlay:Bool = false
    init(resourceName:String) {
        self.resourceName = resourceName
    }
    func playAudio(){
        if isPlay { return }
        guard let fileUrl = Bundle.main.url(forResource: resourceName, withExtension: "mp3") else {return}
        do {
            try player = AVAudioPlayer(contentsOf: fileUrl)
            player.play()
            self.isPlay = true
        } catch let err {
            print(err.localizedDescription)
        }
        Timer(timeInterval: 1, repeats: false) { _ in
            self.isPlay = false
        }.fire()
    }
}
