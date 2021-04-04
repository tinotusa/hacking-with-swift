//
//  UserRow.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 4/4/21.
//

import SwiftUI



struct UserRow: View {
    let user: User
    
    var body: some View {
        VStack(alignment: .leading) {
            HStack {
                Icon(user: user)
                VStack(alignment: .leading) {
                    HStack {
                    Text(user.name)
                        .font(.headline)
                    Text("\(user.age)")
                        .foregroundColor(.secondary)
                    }
                    Text(user.email)
                        .foregroundColor(.secondary)
                }
            }
            
        }
    }
}

struct UserRow_Previews: PreviewProvider {
    static let user = User.testUser
    
    static var previews: some View {
        UserRow(user: user)
    }
}
