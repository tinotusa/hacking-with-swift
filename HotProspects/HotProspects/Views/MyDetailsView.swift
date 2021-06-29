//
//  MyDetailsView.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import SwiftUI

struct MyDetailsView: View {
    @State private var personalDetails = PersonalDetails()

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    Text("Name:")
                    TextField("Name", text: $personalDetails.name)
                }
                HStack {
                    Text("Email: ")
                    TextField("Email", text: $personalDetails.email)
                }
                Divider()
                if personalDetails.validDetails {
                    HStack {
                        Text("Your QRCode")
                        Spacer()
                    }
                    QRCodeView(text: personalDetails.combindedDetails)
                } else {
                    Spacer()
                    Text("Enter a name and email to generate QR code")
                    Spacer()
                }
                Spacer()
            }
            .textFieldStyle(RoundedBorderTextFieldStyle())
            .disableAutocorrection(true)
            .padding(.horizontal)
            .navigationTitle("My Details")
        }
    }
}


struct MyDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        MyDetailsView()
    }
}
