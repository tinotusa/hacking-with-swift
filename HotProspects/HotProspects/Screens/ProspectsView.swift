//
//  ProspectsView.swift
//  HotProspects
//
//  Created by Tino on 7/4/21.
//

import SwiftUI
import CodeScanner

struct ProspectsView: View {
    let filter: FilterType
    @EnvironmentObject var prospects: Prospects
    @State private var isShowingScanner = false
    @State private var showingSortSheet = false
    @State private var sortKey = SortKey.recent
    
    var body: some View {
        NavigationView {
            List {
                ForEach(sort(by: sortKey)) { prospect in
                    ProspectRow(prospect: prospect, filterType: filter)
                }
                .onDelete(perform: prospects.delete)
            }
            .navigationBarTitle(title)
            .navigationBarItems(
                leading: EditButton(),
                trailing:
                    HStack {
                        Button("Sort") { showingSortSheet = true}
                        Divider()
                        AddButton
                    }
            )
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "test\ntest@email.com", completion: handleScan)
            }
            .actionSheet(isPresented: $showingSortSheet) {
                ActionSheet(
                    title: Text("Sort"),
                    message: Text("Select a sorting order"),
                    buttons: [
                        .default(Text("Name"))          { sortKey = .name },
                        .default(Text("Recent"))        { sortKey = .recent },
                        .default(Text("Contacted"))     { sortKey = .contacted },
                        .default(Text("Not contacted")) { sortKey = .notContacted },
                        .cancel(Text("Cancel"))
                    ])
            }
        }
    }
}

// MARK: Functions and computed properties
extension ProspectsView {
    var AddButton: some View {
        Button(action: { isShowingScanner = true }) {
            Image(systemName: "qrcode.viewfinder")
            Text("Scan")
        }
    }
    
    var title: String {
        switch filter {
        case .none:         return "Everyone"
        case .contacted:    return "Contacted People"
        case .uncontacted:  return "Uncontacted People"
        }
    }
    
    var filteredProspects: [Prospect] {
        switch filter {
        case .none: return prospects.people
        case .contacted: return prospects.filter { $0.isContacted }
        case .uncontacted: return prospects.filter { !$0.isContacted }
        }
    }
    
    func handleScan(result: Result<String, CodeScannerView.ScanError>) {
        isShowingScanner = false
        switch result {
        case .success(let code):
            let details = code.components(separatedBy: "\n")
            guard details.count == 2 else { return }
            let person = Prospect(name: details[0], emailAddress: details[1])
            prospects.add(person)
        case .failure(_):
            print("Scan failed")
        }
    }

//  MARK: Sorting
    enum SortKey {
        case name, recent, contacted, notContacted
    }
    
    func sort(by sortKey: SortKey) -> [Prospect] {
        switch sortKey {
        case .name:
            return filteredProspects.sorted { $0.name < $1.name }
        case .contacted:
            return filteredProspects.sorted { $0.isContacted && !$1.isContacted }
        case .notContacted:
            return filteredProspects.sorted { !$0.isContacted && $1.isContacted }
        case .recent:
            return filteredProspects.reversed()
        }
    }
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
