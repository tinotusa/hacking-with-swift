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
    
    var body: some View {
        ZStack {
            // background here
            Button("Authenticate", action: authenticate)
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
