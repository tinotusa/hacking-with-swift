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
    let context = LAContext()
    let imageLoader = ImageLoader()
    let url = "https://www.fodors.com/wp-content/uploads/2018/10/HERO_UltimateRome_Hero_shutterstock789412159.jpg"
    @State private var image: Image? = nil
    
    var body: some View {
        GeometryReader { proxy in
            ZStack {
                image?
                    .resizable()
                    .scaledToFill()
                    .blur(radius: 10)
                
                image?
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width)
                    .shadow(radius: 10)
                
                VStack {
                    Spacer()
                    Button(action: authenticate) {
                        Text("Authenticate")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(10)
                    }
                }
            }
            .frame(width: proxy.size.width)
        }
        .onAppear {
            if let uiImage = imageLoader.load(string: url) {
                image = Image(uiImage: uiImage)
            }
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
