//
//  SettingsView.swift
//  Flashzilla
//
//  Created by Tino on 2/9/21.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settingsData: SettingsData
    
    @State private var mute = false
    @State private var volume: Double = 0
    @State private var timeLimit = ""
    @State private var repeatQuestions = false
    @State private var useHaptics = false
    
    var body: some View {
        Form {
            Section(header: Text("Volume")) {
                Toggle("Mute", isOn: $mute.animation())
                if !mute {
                    Slider(value: $volume)
                }
            }
            Section(header: Text("Time limit (secconds)")) {
                TextField("Time limit", text: $timeLimit)
                    .keyboardType(.numberPad)
            }
            Toggle("Repeat incorrect questions", isOn: $repeatQuestions)
            Toggle("Use haptics (vibrations)", isOn: $useHaptics)
            Button("Save", action: saveAction)
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("Save", action: saveAction)
            }
        }
        .dismissable {
            presentationMode.wrappedValue.dismiss()
        }
        .onAppear {
            mute = settingsData.mute
            volume = settingsData.volume
            timeLimit = String(settingsData.timeLimit)
            repeatQuestions = settingsData.repeatQuestions
            useHaptics = settingsData.haptics
        }
    }
    
    private func saveAction() {
        settingsData.mute = mute
        settingsData.volume = volume
        settingsData.timeLimit = Int(timeLimit) ?? SettingsData.defaultTimeLimit
        settingsData.repeatQuestions = repeatQuestions
        settingsData.haptics = useHaptics
        settingsData.save()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
            .environmentObject(SettingsData())
    }
}
