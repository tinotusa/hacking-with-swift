//
//  Settings.swift
//  Flashzilla
//
//  Created by Tino on 2/9/21.
//

import Foundation

struct Settings: Codable {
    /// The volume of the audio.
    var volume: Double = 0.5
    /// Toogle to repeat questions the user got incorrect or not.
    var repeatQuestions = false
    /// Toggle vibration on or off.
    var shouldUseHaptics = true
    /// Whether the app should play any audo.
    var mute = false
    /// The time limit for each session.
    var timeLimit = 60
}
