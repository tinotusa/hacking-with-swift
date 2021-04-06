//
//  LockedView.swift
//  BucketList
//
//  Created by Tino on 6/4/21.
//

import SwiftUI

struct LockedView: View {
    @Binding var alertItem: AlertItem?
    @Binding var isUnlocked: Bool
    
    var body: some View {
        Button(action: authenticate) {
            Text("Unlock places")
        }
        .padding()
        .background(Color.blue)
        .foregroundColor(.white)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}

// MARK: authentication
import LocalAuthentication

extension LockedView {
    func authenticate() {
        let context = LAContext()
        var error: NSError?
        if !context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error) {
            // no biometrics
            return
        }
        if let error = error as NSError? {
            alertItem = AlertItem(
                title: "Error",
                message: "\(error.domain) \(error.userInfo)"
            )
        }
        let reason = "Unlock to see your saved places"
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                if success {
                    isUnlocked = true
                } else {
                    if let error = error as NSError? {
                        alertItem = AlertItem(
                            title: "Error",
                            message: "\(error.domain) \(error.userInfo)"
                        )
                    }
                }
            }
        }
    }
}

struct LockedView_Previews: PreviewProvider {
    static var previews: some View {
        LockedView(
            alertItem: .constant(AlertItem(title: "Test")),
            isUnlocked: .constant(true)
        )
    }
}
