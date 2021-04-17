//
//  SettingsScreen.swift
//  GuessTheFlag
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

// MARK: TODO
// remove hardcoded values where possible
// maybe use an extension .varelaFont(size: x)
// instead of .font(.custom("varela round", size: x)

struct SettingsScreen: View {
    @Environment(\.presentationMode) var presentationMode
    @EnvironmentObject var settingsModel: SettingsModel
    
    @State private var testBool = false
    @State private var testValue = 10
    
    var body: some View {
        let shouldRepeatQuestions = Binding<Bool>(
            get: { settingsModel.shouldRepeatQuestions },
            set: {
                settingsModel.shouldRepeatQuestions = $0
                settingsModel.save()
            }
        )
        let numberOfQuestions = Binding<Int>(
            get: { settingsModel.numberOfQuestions },
            set: {
                settingsModel.numberOfQuestions = $0
                settingsModel.save()
            }
        )
        return ZStack {
            background

            ScrollView(showsIndicators: false) {
                VStack(spacing: 30) {
                    
                    Spacer().frame(height: 0)
                    
                    Text("Settings")
                        .font(.custom("Varela Round", size: 80))
                        .foregroundColor(Color("pink"))
                        .customUnderline()
                    
                    Spacer().frame(height: 0)
                    
                    SettingsItem("Repeat wrong questions?", size: 20, content: CustomToggle(isOn: shouldRepeatQuestions))
                        .frame(height: 60)
                    
                    SettingsItem("Number of questions", size: 16, content: CustomStepper(value: numberOfQuestions))
                        .frame(height: 60)
                    
                    Spacer()
                    
                }
                .padding()
                
                Image("Flag pole - uk")
                    .scaleEffect(1.4)
                    .position(x: 140, y: 300)
            }
            
            backButton
        }
        .navigationBarHidden(true)
        
    }
}

private extension SettingsScreen {
    var background: some View {
        Color("blue")
            .ignoresSafeArea()
    }
    
    var backButton: some View {
        HStack {
            Image("Back button")
                .onTapGesture(perform: backToMainMenu)
            Spacer()
        }
        .position(x: 210, y: 20)
    }
    
    func backToMainMenu() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        SettingsScreen()
            .environmentObject(SettingsModel())
    }
}
