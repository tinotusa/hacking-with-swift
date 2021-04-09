//
//  Settings.swift
//  Flashzilla
//
//  Created by Tino on 9/4/21.
//

import SwiftUI

struct Settings: View {
    @Binding var shouldRepeat: Bool
    @Environment(\.presentationMode) var presentationMode
    var body: some View {
        NavigationView {
            Form {
                Toggle("Repeat incorrect questions", isOn: $shouldRepeat)
            }
            .navigationBarTitle("Settings")
            .navigationBarItems(trailing: Button("Done", action: dismiss))
        }
    }
}

extension Settings {
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct Settings_Previews: PreviewProvider {
    static var previews: some View {
        Settings(shouldRepeat: .constant(false))
    }
}
