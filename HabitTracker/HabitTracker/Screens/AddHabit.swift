//
//  AddHabit.swift
//  HabitTracker
//
//  Created by Tino on 31/3/21.
//

import SwiftUI


struct AddHabit: View {
    @ObservedObject var tracker: Tracker
    
    @State private var name = ""
    @State private var timesCompeted = ""
    @State private var description = ""
    @State private var dateCompleted = Date()
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Form {
            Section {
                TextField("Habit name", text: $name)
                TextField("Times competed", text: $timesCompeted)
                    .keyboardType(.numberPad)
                TextField("Habit Description", text: $description)
                
            }
            
            Section {
                DatePicker("Time completed", selection: $dateCompleted, in: Date()..., displayedComponents: [.hourAndMinute])
            }
            
            Section {
                Button(action: addHabit) {
                    Text("Add")
                }
                .disabled(!validForm)
            }
        }
    }
    
    var validForm: Bool {
        if Int(timesCompeted) == nil {
            return false
        }
        return !name.isEmpty
    }
    
    func addHabit() {
        let timesCompleted = Int(self.timesCompeted) ?? 0
        let newHabit = Habit(name: name, timesCompleted: timesCompleted, description: description)
        
        tracker.addHabit(newHabit)
        presentationMode.wrappedValue.dismiss()
    }
}

struct AddHabit_Previews: PreviewProvider {
    static var previews: some View {
        AddHabit(tracker: Tracker())
    }
}
