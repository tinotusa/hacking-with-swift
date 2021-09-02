//
//  AudioPlayer.swift
//  Flashzilla
//
//  Created by Tino on 2/9/21.
//

import AVFoundation
import SwiftUI

struct AudioPlayer {
    static var audioPlayer: AVAudioPlayer?
    
    static func playAudio(_ name: String) {
        if let path = Bundle.main.path(forResource: name, ofType: nil) {
            do {
                audioPlayer = try AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
                audioPlayer?.volume = 1
                audioPlayer?.prepareToPlay()
                audioPlayer?.play()
            } catch {
                print(error)
            }
        }
    }
    
    static func playCorrectAudio() {
        playAudio("correct.wav")
    }
}
