//
//  ContentView.swift
//  CoreDataProject
//
//  Created by Tino on 2/4/21.
//

import SwiftUI
import CoreData

struct Student: Hashable {
    var name: String
}

struct First: View {
    let students = [Student(name: "test"), Student(name: "Another one")]
    
    @FetchRequest(entity: Movie.entity(), sortDescriptors: [])
    var movies: FetchedResults<Movie>
    
    @Environment(\.managedObjectContext) var viewContext
    
    var body: some View {
        NavigationView {
            List {
                ForEach(movies) { movie in
                    VStack(alignment: .leading) {
                        Text(movie.wrappedTitle)
                            .font(.headline)
                        Text(movie.wrappedDirector)
                            .foregroundColor(.secondary)
                    }
                }
                .onDelete(perform: deleteMovies)
            }
            .navigationBarTitle("Core data project")
            .navigationBarItems(trailing: Button("Add") {
                let movie = Movie(context: viewContext)
                movie.title = "The Good, the bad, and the ugly"
                movie.director = "Some one"
                movie.year = 3000
                saveContext()
            })
        }
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try withAnimation {
                    try viewContext.save()
                }
            } catch (let error as NSError) {
                print("Unresolved error: \(error.localizedDescription)")
            }
        }
    }
    
    func deleteMovies(at offsets: IndexSet) {
        offsets.map { movies[$0] } .forEach(viewContext.delete)
        saveContext()
    }
}

struct Second: View {
    @Environment(\.managedObjectContext)
    var viewContext
    
    @FetchRequest(
        entity: Ship.entity(),
        sortDescriptors: [],
        predicate: NSPredicate(format: "NOT name BEGINSWITH[c] %@", "e"))
    var ships: FetchedResults<Ship>
    
    var body: some View {
        VStack {
            Text("Ships")
                .font(.headline)
            List{
                ForEach(ships) { ship in
                    Text(ship.name ?? "Unknown name")
                }
                .onDelete(perform: deleteShips)
            }
            
            HStack {
                Button("Add examples") {
                    createShip(name: "Enterprise", universe: "Star Trek")
                    createShip(name: "Defiant", universe: "Star Trek")
                    createShip(name: "Millenium Falcon", universe: "Star Wars")
                    createShip(name: "Executor", universe: "Star Wars")
                    saveContext()
                }
                Button("Delete all") {
                    deleteAll()
                }
            }
        }
    }
    
    func deleteAll() {
        ships.forEach(viewContext.delete)
        saveContext()
    }
    
    func deleteShips(at offsets: IndexSet) {
        offsets.map { ships[$0] }.forEach(viewContext.delete)
        saveContext()
    }
    func createShip(name: String, universe: String) {
        let ship = Ship(context: viewContext)
        ship.name = name
        ship.universe = universe
    }
    
    func saveContext() {
        if !viewContext.hasChanges { return }
        do {
            try withAnimation {
                try viewContext.save()
            }
        } catch let error as NSError {
            print("Error code: \(error.code) domain: \(error.domain)")
        }
    }
}

struct Third: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Country.entity(), sortDescriptors: [])
    var counties: FetchedResults<Country>
    
    var body: some View {
        VStack {
            List {
                ForEach(counties, id: \.self) { country in
                    Section(header: Text(country.wrappedFullName)) {
                        ForEach(country.candyArray, id: \.self) { candy in
                            Text(candy.wrappedName)
                        }
                    }
                }
            }
            Button(action: addCandy) {
                Text("Add candy")
            }
        }
    }
    
    func addCandy() {
        let uk = createCountry(fullName: "United Kingdom", shortName: "UK")
        let _ = createCandy(name: "Mars", origin: uk)
        let _ = createCandy(name: "KitKat", origin: uk)
        let _ = createCandy(name: "Twix", origin: uk)
        
        let switzerland = createCountry(fullName: "Switzerland", shortName: "CH")
        let _ = createCandy(name: "Toblerone", origin: switzerland)
        
        saveContext()
    }
    
    func createCountry(fullName: String, shortName: String) -> Country {
        let country = Country(context: viewContext)
        country.fullName = fullName
        country.shortName = shortName
        return country
    }
    
    func createCandy(name: String, origin: Country) -> Candy {
        let candy = Candy(context: viewContext)
        candy.name = name
        candy.origin = origin
        
        return candy
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error as NSError {
                print("Error saving viewContext: \(error.domain)")
            }
        }
    }
}

struct Fourth: View {
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Ship.entity(), sortDescriptors: [])
    var ships: FetchedResults<Ship>
 
    @State private var filter = "BEGINSWITH[C]"
    @State private var key = "name"
    @State private var value = "e"
    @State private var predicate = PredicateString.beginsWith
    var body: some View {
        VStack {
            Button(action: addShips) {
                Text("Add some ships")
            }
            Picker("Predicate: \(predicate.rawValue)", selection: $predicate) {
                ForEach(PredicateString.allCases, id: \.self) { predicate in
                    Text(predicate.rawValue)
                }
            }
            TextField("value", text: $value)
            
            FilterList(
                filter: predicate,
                key: key,
                value: value,
                sortDescriptors: [
                    NSSortDescriptor(key: "name", ascending: true)
                ]) { (item: Ship) in
                VStack {
                    Text(item.name ?? "Unknown name")
                }
            }
        }
        .textFieldStyle(RoundedBorderTextFieldStyle())
        .padding()
//        .onAppear(perform: deleteAll)
    }
    
    func addShips() {
        createShip(name: "Enterprise", universe: "Star Trek")
        createShip(name: "Defiant", universe: "Star Trek")
        createShip(name: "Millenium Falcon", universe: "Star Wars")
        createShip(name: "Executor", universe: "Star Wars")
        withAnimation {
            saveContext()
        }
    }
    
    func createShip(name: String, universe: String) {
        let ship = Ship(context: viewContext)
        ship.name = name
        ship.universe = universe
    }
    
    func deleteAll() {
        ships.forEach(viewContext.delete)
        saveContext()
    }
    
    func saveContext() {
        if viewContext.hasChanges {
            do {
                try viewContext.save()
            } catch let error as NSError {
                print("Error when saving context \(error.localizedDescription)")
            }
        }
    }
}

enum PredicateString: String, CaseIterable {
    case beginsWith = "BEGINSWITH"
    case contains = "CONTAINS"
    case equalTo = "=="
    case lessThan = "<"
    case greaterThan = ">"
}

struct FilterList<T: NSManagedObject, Content: View>: View {
    var fetchRequest: FetchRequest<T>
    var items: FetchedResults<T> { fetchRequest.wrappedValue }
    
    var content: (T) -> Content
    
    
    
    init(filter: PredicateString, key: String, value: String, sortDescriptors: [NSSortDescriptor], @ViewBuilder content: @escaping (T) -> Content) {
        fetchRequest = FetchRequest<T>(
            entity: T.entity(),
            sortDescriptors: sortDescriptors,
            predicate: NSPredicate(format: "%K \(filter.rawValue) %@", key, value)
        )
        self.content = content
    }
    
    var body: some View {
        List(items, id: \.self) { item in
            content(item)
        }
    }
}

struct ContentView: View {
    @State private var currentTab = 4
    
    var body: some View {
        TabView(selection: $currentTab) {
            First().tag(1)
                .tabItem {
                    Image(systemName: "1.square")
                    Text("First")
                }
            Second().tag(2)
                .tabItem {
                    Image(systemName: "2.square")
                    Text("Second")
                }
            Third().tag(3)
                .tabItem {
                    Image(systemName: "3.square")
                    Text("Third")
                }
            Fourth().tag(4)
                .tabItem {
                    Image(systemName: "4.square")
                    Text("Fourth")
                }
        }
    }
}
struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environment(
                \.managedObjectContext,
                PersistenceController.shared.container.viewContext
            )
    }
}
