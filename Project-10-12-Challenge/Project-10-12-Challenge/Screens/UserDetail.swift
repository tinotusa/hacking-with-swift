//
//  UserDetail.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 4/4/21.
//

import SwiftUI

struct UserDetail: View {
    let user: User
    let users: FetchedResults<User>
    
    @State private var showMore = false
    var body: some View {
        GeometryReader { geometry in
            ScrollView {
                VStack {
                    Icon(user: user, width: 100, height: 100)
                    HStack {
                        Text(user.wrappedName.capitalized)
                            .font(.headline)
                        Text("\(user.age)")
                    }
                    Text(user.wrappedEmail)
                    Text(user.wrappedAddress)
                    Text("Company: \(user.wrappedCompany)")
                    Text(about)
                        .layoutPriority(1)
                    
                    if showMore {
                        Divider()
                        Text("Joinend: \(user.formattedRegistedDate)")
                        Text("Tags")
                        VStack {
                            ForEach(user.wrappedTags, id: \.self) { tag in
                                Text(tag)
                            }
                        }
                        Divider()
                    }
                    
                    List(user.wrappedFriends) { friend in
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
            return user.wrappedAbout
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
    static let viewContext = PersistenceController.shared.container.viewContext
    static let user = User.testUser
    @FetchRequest(entity: User.entity(), sortDescriptors: [])
    static var users: FetchedResults<User>
    
    static var previews: some View {
        let newUser = User(context: viewContext)
        newUser.name = "test name"
        newUser.age = 42
        newUser.isActive = true
        newUser.company = "A company"
        do {
            try viewContext.save()
        } catch {
            print("unresolved error \(error.localizedDescription)")
        }
        
        return UserDetail(user: user, users: users)
            .environment(\.managedObjectContext, viewContext)
    }
}
