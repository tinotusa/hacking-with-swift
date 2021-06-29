//
//  ProspectRow.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import SwiftUI

struct ProspectRow: View {
    @Binding var prospect: Prospect
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prospect.name)
                    .font(.headline)
                Text(prospect.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .contextMenu {
            Button("Mark \(prospect.isContacted ? "un-contacted" : "contacted")") {
                prospect.contact()
            }
        }
    }
}

struct ProspectRow_Preview: PreviewProvider {
    static var previews: some View {
        ProspectRow(prospect: .constant(Prospect(name: "some name", email: "an email")))
    }
}
