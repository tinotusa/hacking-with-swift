//
//  HabitRow.swift
//  HabitTracker
//
//  Created by Tino on 31/3/21.
//

import SwiftUI

struct HabitRow: View {
    let habit: Habit
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(habit.name)
                    .font(.headline)
                Text(habit.shortDescription)
            }
            Spacer()
            Text("\(habit.timesCompleted)")
        }
    }
}
struct HabitRow_Previews: PreviewProvider {
    static var previews: some View {
        HabitRow(habit: Habit(name: "test", timesCompleted: 2))
    }
}
