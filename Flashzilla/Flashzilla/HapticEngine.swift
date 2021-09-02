//
//  HapticEngine.swift
//  Flashzilla
//
//  Created by Tino on 2/9/21.
//

import Foundation
import CoreHaptics

struct HapticEngine {
    var engine: CHHapticEngine?
    
    static var supportsHaptics = CHHapticEngine.capabilitiesForHardware().supportsHaptics
    
    init() {
        if !Self.supportsHaptics {
            return
        }
        do {
            engine = try CHHapticEngine()
        } catch {
            print("Error creating haptic engine: \(error)")
        }
    }
    
    func playHaptic() {
        let events = [
            CHHapticEvent(eventType: .hapticTransient, parameters: [], relativeTime: 1, duration: 0.7)
        ]
        do {
            let pattern = try CHHapticPattern(events: events, parameters: [])
            let player = try engine?.makePlayer(with: pattern)
            try engine?.start()
            try player?.start(atTime: 0)
        } catch {
            print("Error playing haptics: \(error)")
        }
    }
}
