//
//  ResultsView.swift
//  DiceRoll
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

struct ResultsView: View {
    @EnvironmentObject var diceRoller: DiceRoller
    
    @Environment(\.managedObjectContext) var viewContext
    @FetchRequest(entity: Roll.entity(), sortDescriptors: [])
    var rolls: FetchedResults<Roll>
    
    var body: some View {
        VStack {
            List {
                ForEach(rolls, id: \.self) { roll in
                    Section(header: Text("Roll set #\(roll.index)")) {
                        ForEach(roll.wrappedResults.indices, id: \.self) { index in
                            Text("Roll #\(index + 1) = \(roll.wrappedResults[index])")
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
        }
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        ResultsView()
    }
}
