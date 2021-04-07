//
//  ContentView.swift
//  RememberMe
//
//  Created by Tino on 6/4/21.
//

import SwiftUI
import NotificationCenter

struct ContentView: View  {
    @ObservedObject var peopleMet = PeopleMet()
    @State private var showingAddScreen = false
    
    var body: some View {
        NavigationView {
            List {
                ForEach(peopleMet.people) { person in
                    NavigationLink(destination: PersonDetail(person: person, peopleMet: peopleMet)) {
                        PersonRow(person: person)
                    }
                }
                .onDelete(perform: peopleMet.delete)
            }
            .navigationBarTitle("RememberMe")
            .navigationBarItems(
                leading: EditButton(),
                trailing: Button("Add person", action: { showingAddScreen = true })
            )
            .sheet(isPresented: $showingAddScreen) {
                AddView(peopleMet: peopleMet)
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
