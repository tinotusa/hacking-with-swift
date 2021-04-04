//
//  UserDetail.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 4/4/21.
//

import SwiftUI

struct UserDetail: View {
    let user: User
    let users: [User]
    
    @State private var showMore = false
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Icon(user: user, width: 100, height: 100)
                    HStack {
                        Text(user.name.capitalized)
                            .font(.headline)
                        Text("\(user.age)")
                    }
                    Text(user.email)
                    Text(user.address)
                    Text("Company: \(user.company)")
                    Text(about)
                    
                    if showMore {
                        Divider()
                        Text("Joinend: \(user.formattedRegistedDate)")
                        Text("Tags")
                        HStack {
                            ForEach(user.tags, id: \.self) { tag in
                                Text(tag)
                            }
                        }
                    }
                    
                    List(user.friends) { friend in
                        NavigationLink(destination: UserDetail(user: findUser(named: friend.name), users: users)) {
                            UserRow(user: findUser(named: friend.name))
                        }
                    }
                }
                .frame(height: geometry.size.height)
                .padding()
                .navigationBarItems(trailing: Button("Show \(showMore ? "less" : "more")") {
                    withAnimation {
                        showMore.toggle()
                    }
                })
            }
        }
    }
    
    var about: String {
        if showMore {
            return user.about
        } else {
            return user.shortAbout
        }
    }
    
    func findUser(named name: String) -> User {
        guard let user = users.first(where: { $0.name == name }) else {
            fatalError("Failed to find user \(name)")
        }
        return user
    }
}

struct UserDetail_Previews: PreviewProvider {
    static let user = User.testUser
    static let users = [User]()

    static var previews: some View {
        UserDetail(user: user, users: users)
    }
}
