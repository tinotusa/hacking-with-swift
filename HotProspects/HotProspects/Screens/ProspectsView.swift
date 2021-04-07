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
    
    var body: some View {
        NavigationView {
            List {
                ForEach(filteredProspects) { prospect in
                    ProspectRow(prospect: prospect)
                }
                .onDelete(perform: prospects.delete)
            }
            .navigationBarTitle(title)
            .navigationBarItems(leading: EditButton(), trailing: AddButton)
            .sheet(isPresented: $isShowingScanner) {
                CodeScannerView(codeTypes: [.qr], simulatedData: "test\ntest@email.com", completion: handleScan)
            }
        }
    }
}

// MARK: Functions and computed properties
extension ProspectsView {
    enum FilterType {
        case none, contacted, uncontacted
    }
    
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
}

struct ProspectsView_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsView(filter: .none)
            .environmentObject(Prospects())
    }
}
