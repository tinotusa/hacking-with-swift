//
//  AuthenticationView.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI
import LocalAuthentication

struct AuthenticationView: View {
    @Binding var isAuthenticated: Bool
    let context = LAContext() // try to use combine stuff for this
    let url = URL(string: "https://theawesomedaily.com/wp-content/uploads/2016/08/pictures-of-tokyo-1.jpg")!
    @State private var buttonColour: Color = .blue
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                AsyncImage(url: url) { Text("loading...") }
                    .scaledToFill()
                    .blur(radius: 10)
                    .ignoresSafeArea()
                
                AsyncImage(url: url) { Text("loading...") }
                    .scaledToFit()
                    .frame(width: proxy.size.width)
                    .shadow(radius: 10)
                
                VStack {
                    Spacer()
                    Button(action: authenticate) {
                        Text("Authenticate")
                            .padding()
                            .background(buttonColour)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .frame(width: proxy.size.width)
        }
    }
    
    func authenticate() {
        var error: NSError?
        if !context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error) {
            print("device doesn't have authentication set up")
        }
        let reason = "Unlock to see your saved data"
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
            if success {
                DispatchQueue.main.async {
                    isAuthenticated = true
                }
                return
            }
            if let error = error {
                print(error.localizedDescription)
            }
        }
    }
}

struct AuthenticationView_Previews: PreviewProvider {
    static var previews: some View {
        AuthenticationView(isAuthenticated: .constant(false))
    }
}
