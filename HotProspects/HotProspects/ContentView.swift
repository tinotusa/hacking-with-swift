//
//  ContentView.swift
//  HotProspects
//
//  Created by Tino on 7/4/21.
//

import SwiftUI

struct Prospect: Equatable, Codable, Identifiable, CustomStringConvertible {
    let id = UUID()
    let name: String
    let email: String
    var isContacted = false
    
    init (name: String, email: String) {
        self.name = name
        self.email = email
    }
    
    mutating func contact() {
        isContacted.toggle()
    }
    
    enum CodingKeys: CodingKey {
        case name, email, isContacted
    }
    
    // Equatable conformance
    static func ==(lhs: Prospect, rhs: Prospect) -> Bool {
        lhs.name == rhs.name && lhs.email == rhs.email
    }
    
    // CustomStringConvertible conformance
    var description: String {
        "name: \(name), email: \(email), isContacted: \(isContacted)"
    }
}

class ProspectList: ObservableObject {
    @Published private(set) var prospects: [Prospect] = []
    
    func add(_ prospect: Prospect) {
        prospects.append(prospect)
    }
    
    func remove(_ prospect: Prospect) {
        guard let index = prospects.firstIndex(where: { $0.id == prospect.id }) else {
            fatalError("Tried to remove non existant prospect \(prospect)")
        }
        prospects.remove(at: index)
    }
    
    func remove(offsets: IndexSet) {
        prospects.remove(atOffsets: offsets)
    }
    
    func contact(index: Int) {
        prospects[index].contact()
    }
    
    subscript(_ index: Int) -> Prospect {
        prospects[index]
    }
}

struct ProspectRow: View {
    @EnvironmentObject var prospectList: ProspectList
    let prospect: Prospect
    
    var index: Int {
        // error: returns nil somehow
        prospectList.prospects.firstIndex(where: { $0.id == prospect.id })!
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prospectList[index].name)
                    .font(.headline)
                Text(prospectList[index].email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
        }
        .contextMenu {
            Button("Mark \(prospectList[index].isContacted ? "un-contacted" : "contacted")") {
                prospectList.contact(index: index)
            }
        }
    }
}

struct AllProspectsTab: View {
    @EnvironmentObject var prospectList: ProspectList
    
    var body: some View {
        NavigationView {
            List {
                ForEach(prospectList.prospects) { prospect in
                    ProspectRow(prospect: prospect)
                }
                .onDelete(perform: prospectList.remove)
            }
            .navigationTitle("All prospects")
            .navigationBarItems(trailing: HStack {
                EditButton()
                
                Button(action: {
                    prospectList.add(Prospect(name: "test\(Int.random(in: 0...100))", email: "test@email.com"))
                }) {
                    Image(systemName: "plus")
                }
            })
        }
    }
    
}

struct ContentView: View {
    @EnvironmentObject var prospectList: ProspectList
    
    var body: some View {
        TabView {
            AllProspectsTab()
                .tabItem {
                    Label("all", systemImage: "person.3")
                }
            Text("Contacted view")
                .tabItem {
                    Label("Contacted", systemImage: "star")
                }
            Text("My details")
                .tabItem {
                    Label("My Details", systemImage: "person")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(ProspectList())
    }
}
