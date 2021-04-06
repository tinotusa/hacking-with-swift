//
//  ContentView.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 4/4/21.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(
        entity: User.entity(),
        sortDescriptors: [NSSortDescriptor(key: "name", ascending: true)],
        predicate: nil
    ) var users: FetchedResults<User>
    
    var body: some View {
        NavigationView {
            List(users) { user in
                NavigationLink(destination: UserDetail(user: user, users: users)) {
                    UserRow(user: user)
                }
            }
            .navigationBarTitle("Users")
            .navigationBarItems(trailing: Button(action: loadUsers) {
                Text("Get user data")
            })
        }
    }
}

// MARK: helper functions
extension ContentView {
    func loadUsers() {
        if !users.isEmpty { return }
        getUsers { result in
            switch result {
            case .success(let data):
                data.forEach(addUser)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    func addUser(user: UserStruct) {
        let newUser = User(context: viewContext)
        newUser.id = user.id
        newUser.age = Int16(user.age)
        newUser.isActive = user.isActive
        newUser.name = user.name
        newUser.company = user.company
        newUser.email = user.email
        newUser.address = user.address
        newUser.about = user.about
        newUser.registered = user.registered
        do {
            newUser.tags = try JSONEncoder().encode(user.tags)
            newUser.friends = try JSONEncoder().encode(user.friends)
        } catch {
            print("unresolved error \(error.localizedDescription)")
        }

        saveContext()
    }

    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch {
                print(error)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(
                \.managedObjectContext,
                PersistenceController.shared.container.viewContext)
    }
}
