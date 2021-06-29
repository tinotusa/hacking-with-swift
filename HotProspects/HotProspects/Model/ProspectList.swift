//
//  ProspectList.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import Foundation

class ProspectList: ObservableObject {
    @Published var prospects: [Prospect] = []
    
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
