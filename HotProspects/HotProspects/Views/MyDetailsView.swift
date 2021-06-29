//
//  MyDetailsView.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import SwiftUI

struct MyDetailsView: View {
    @State private var name = ""
    @State private var email = ""

    var body: some View {
        NavigationView {
            VStack {
                TextField("Name", text: $name)
                TextField("Email", text: $email)
                if fieldsHaveText {
                    Text("Your QRCode")
                    QRCodeView(text: details)
                }
                Spacer()
            }
            .disableAutocorrection(true)
            .padding(.horizontal)
            .navigationTitle("My Details")
        }
    }
    
    private var details: String {
        name + "\n" + email
    }
    
    private var fieldsHaveText: Bool {
        let name = name.trimmingCharacters(in: .newlines)
        let email = email.trimmingCharacters(in: .newlines)
        return !name.isEmpty && !email.isEmpty
    }
}


struct MyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MyDetailsView()
    }
}
