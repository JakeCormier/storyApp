//
//  Audio.swift
//  InteractiveStory
//
//  Created by Jake Cormier on 8/14/17.
//  Copyright © 2017 Government Entertainment. All rights reserved.
//

import Foundation
import AudioToolbox

extension Story {
    var soundEffectname: String {
        switch self {
        case .droid,  .home: return "HappyEnding"
        case .monster: return "Omnious"
        default: return "PageTurn"
        }
    }
    
    var soundEffectURL: URL {
        let path = Bundle.main.path(forResource: soundEffectname, ofType: "wav")!
        return URL(fileURLWithPath: path)
    }
}

class SoundEffectsPlayer {
    var sound: SystemSoundID = 0 // stores the sound we want to play
    
    func playSound(for story: Story) {
        let soundURL = story.soundEffectURL as CFURL
        AudioServicesCreateSystemSoundID(soundURL, &sound) //& creates an in out parameter
        AudioServicesPlaySystemSound(sound)
    }
}
