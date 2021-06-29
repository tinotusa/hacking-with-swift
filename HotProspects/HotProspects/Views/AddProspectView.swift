//
//  AddProspectView.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import SwiftUI

struct AddProspectView: View {
    @EnvironmentObject var prospectList: ProspectList
    @Environment(\.presentationMode) var presentationMode
    
    @State private var name = ""
    @State private var email = ""
    
    var body: some View {
        Form {
            TextField("Name", text: $name)
            TextField("Email", text: $email)
            Button("Add", action: addProspect)
                .disabled(!allFormsFilled)
        }
        .disableAutocorrection(true)
        .navigationTitle("Add new person")
        .navigationBarItems(trailing:
            Button("Scan QRCode") {
                // show qrcode scanner
            }
        )
    }
    
    private var allFormsFilled: Bool {
        let name = self.name.trimmingCharacters(in: .whitespacesAndNewlines)
        let email = self.email.trimmingCharacters(in: .whitespacesAndNewlines)
        return !name.isEmpty && !email.isEmpty
    }
    
    private func addProspect() {
        let prospect = Prospect(name: name, email: email)
        prospectList.add(prospect)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddProspectView_Previews: PreviewProvider {
    static var previews: some View {
        AddProspectView()
            .environmentObject(ProspectList())
    }
}
