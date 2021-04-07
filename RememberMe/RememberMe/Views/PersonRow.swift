//
//  PersonRow.swift
//  RememberMe
//
//  Created by Tino on 7/4/21.
//

import SwiftUI

struct PersonRow: View {
    let person: Person

    var body: some View {
        HStack {
            person.getImage()
                .resizable()
                .frame(width: 50, height: 50)
                .accessibility(hidden: true)
            VStack {
                Text(person.name)
                // more info?
            }
            .accessibilityElement(children: .ignore)
            .accessibility(label: Text(person.name))
        }
    }
}

struct PersonRow_Previews: PreviewProvider {
    static var previews: some View {
        PersonRow(person: Person(name: "Test User"))
    }
}
