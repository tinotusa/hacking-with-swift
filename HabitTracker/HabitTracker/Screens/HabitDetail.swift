//
//  HabitDetail.swift
//  HabitTracker
//
//  Created by Tino on 31/3/21.
//

import SwiftUI

struct HabitDetail: View {
    @ObservedObject var tracker: Tracker
    let habit: Habit
    @State private var timesCompleted = 0
    
    var body: some View {
        return VStack {
            Text(habit.name)
                .font(.largeTitle)
            Text(habit.description.isEmpty ? "Description N/A" : habit.description)
            Stepper("Times completed: \(timesCompleted)", value: $timesCompleted)
            Spacer()
        }
        .padding()
        .onAppear {
            timesCompleted = habit.timesCompleted
        }
    }
}
struct HabitDetail_Previews: PreviewProvider {
    static var previews: some View {
        HabitDetail(tracker: Tracker(), habit: Habit(name: "test", timesCompleted: 3, description: ""))
    }
}
