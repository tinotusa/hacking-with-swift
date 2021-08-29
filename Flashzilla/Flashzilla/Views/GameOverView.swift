//
//  GameOverView.swift
//  Flashzilla
//
//  Created by Tino on 29/8/21.
//

import SwiftUI

struct GameOverView: View {
    @EnvironmentObject var userData: UserData
    
    private var total: Int { userData.totalCards }
    
    var body: some View {
        VStack {
            Text("Score: \(userData.correctCount) / \(total)")
            HStack {
                Button("Play again") {
                    userData.reset()
                }
            }
        }
    }
}
struct GameOverView_Previews: PreviewProvider {
    static var previews: some View {
        GameOverView()
            .environmentObject(UserData())
    }
}
