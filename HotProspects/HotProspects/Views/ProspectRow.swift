//
//  ProspectRow.swift
//  HotProspects
//
//  Created by Tino on 29/6/21.
//

import SwiftUI
import UserNotifications

struct ProspectRow: View {
    @Binding var prospect: Prospect
    private let iconSize = CGFloat(25.0)
    private let center = UNUserNotificationCenter.current()
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(prospect.name)
                    .font(.headline)
                Text(prospect.email)
                    .font(.subheadline)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            reminderButton
           
            contactedMarker
            
        }
        .padding(.horizontal)
        .contextMenu {
            Button("Mark \(prospect.isContacted ? "un-contacted" : "contacted")") {
                prospect.contact()
            }
        }
    }
    
    private var reminderButton: some View {
        Button {
            print("setting reminder")
            askNotificationPermission()
            setNotification()
        } label: {
            Image(systemName: "alarm")
                .renderingMode(.original)
                .resizable()
                .frame(width: iconSize, height: iconSize)
        }
    }
    
    private var contactedMarker: some View {
        Group {
            if prospect.isContacted {
                Image(systemName: "checkmark")
            } else {
                Spacer().frame(width: iconSize)
            }
        }
    }
    
    private func askNotificationPermission() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { granted, error in
            if let error = error {
                print(error)
            }
        }
    }
    
    private func setNotification() {
        center.getNotificationSettings { settings in
            guard settings.authorizationStatus == .authorized else {
                return
            }
            
            let content = UNMutableNotificationContent()
            content.title = "Reminder"
            content.body = "Contact \(prospect.name)"
            
            var dateComponents = DateComponents()
            dateComponents.calendar = .current
            dateComponents.hour = 8
            
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false) // testing only
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            
            let uuidString = UUID().uuidString
            let request = UNNotificationRequest(identifier: uuidString,
                                                content: content,
                                                trigger: trigger)
            center.add(request) { error in
                if let error = error {
                    print(error)
                }
            }
        }
    }
}

struct ProspectRow_Preview: PreviewProvider {
    static var previews: some View {
        ProspectRow(prospect: .constant(Prospect(name: "some name", email: "an email")))
    }
}
