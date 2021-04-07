//
//  EditView.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import Foundation
import SwiftUI

struct EditView: View {
    let person: Person
    @ObservedObject var peopleMet: PeopleMet
    
    @Environment(\.presentationMode) var presentationMode
    @State private var name = ""
    @State private var description = ""
    
    var body: some View {
        Form {
            Section(header: Text("Information")) {
                TextField("Name", text: $name)
                TextField("Description", text: $description)
            }
            Button(action: saveEdit) {
                Text("Done")
            }
        }
    }
    
    func saveEdit() {
        peopleMet.edit(person, name: name, description: description)
        presentationMode.wrappedValue.dismiss()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(person: Person(name: "test name"), peopleMet: PeopleMet())
    }
}
