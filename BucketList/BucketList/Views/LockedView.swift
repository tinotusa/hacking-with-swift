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
        
        let hasBiometrics = context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &error)
        let hasPasscode = context.canEvaluatePolicy(.deviceOwnerAuthentication, error: &error)
        
        if !hasPasscode && !hasBiometrics {
            // no form of authentication
            return
        }

        let reason = "Unlock to see your saved places"
        
        if hasBiometrics {
            authenticateWithBiometrics(context: context, reason: reason)
        } else {
            authenticateWithPasscode(context: context, reason: reason)
        }
    }
    
    func authenticateWithBiometrics(context: LAContext, reason: String) {
        context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics,localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                if success {
                    isUnlocked = true
                    return
                }
                if let error = error as NSError? {
                    alertItem = AlertItem(
                        title: "Biometrics Error",
                        message: "\(error.domain) \(error.userInfo)"
                    )
                }
            }
        }
    }
    
    func authenticateWithPasscode(context: LAContext, reason: String) {
        context.evaluatePolicy(.deviceOwnerAuthentication, localizedReason: reason) { success, error in
            DispatchQueue.main.async {
                if success {
                    isUnlocked = true
                    return
                }
                if let error = error as NSError? {
                    alertItem = AlertItem(
                        title: "Passcode Error",
                        message: "\(error.domain) \(error.userInfo)"
                    )
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
