//
//  ProspectsTab.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import SwiftUI


enum ProspectTab: String {
    case all = "All Prospects"
    case contacted = "Contacted"
}

struct ProspectsTab: View {
    @EnvironmentObject var prospectList: ProspectList
    @State private var showingAddScreen = false
    var tab: ProspectTab
    
    var body: some View {
        NavigationView {
            VStack {
                NavigationLink(
                    destination: AddProspectView(),
                    isActive: $showingAddScreen
                ) {
                    EmptyView()
                }
                
                List {   
                    ForEach(prospectList.prospects.indices, id: \.self) { index in
                        if tab == .contacted {
                            if prospectList.prospects[index].isContacted {
                                ProspectRow(prospect: $prospectList.prospects[index])
                            }
                        } else {
                            ProspectRow(prospect: $prospectList.prospects[index])
                        }
                    }
                    .onDelete(perform: prospectList.remove)
                }
                .navigationTitle(tab.rawValue)
                .navigationBarItems(trailing: HStack {
                    EditButton()
                    
                    Button(action: {
                        showingAddScreen = true
    //                    prospectList.add(Prospect(name: "test\(Int.random(in: 0...100))", email: "test@email.com"))
                    }) {
                        Image(systemName: "plus")
                    }
                })
            }
        }
    }
    
    var prospects: [Prospect] {
        if tab == .all {
            return prospectList.prospects
        }
        return prospectList.prospects.filter { $0.isContacted }
    }
    
}


struct ProspectsTab_Previews: PreviewProvider {
    static var previews: some View {
        ProspectsTab(tab: .all)
            .environmentObject(ProspectList())
    }
}
