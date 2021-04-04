//
//  ContentView.swift
//  Project-10-12-Challenge
//
//  Created by Tino on 4/4/21.
//

import SwiftUI

struct ContentView: View {
    @State private var users = [User]()
    @State private var loadedData = false
    
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
    
    func loadUsers() {
        if loadedData { return }
        loadedData = true
        getUsers { result in
            switch result {
            case .success(let data):
                users = data
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
}



struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
