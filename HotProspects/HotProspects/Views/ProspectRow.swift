//
//  ProspectRow.swift
//  HotProspects
//
//  Created by Tino on 7/4/21.
//

import SwiftUI
import UserNotifications

struct ProspectRow: View {
    let prospect: Prospect
    @EnvironmentObject var prospects: Prospects
    
    var body: some View {
        VStack(alignment: .leading) {
            Text(prospect.name)
                .font(.headline)
            Text(prospect.emailAddress)
                .foregroundColor(.secondary)
        }
        .contextMenu {
            Button(prospect.isContacted ? "Mark Uncontacted" : "Mark Contacted") {
                prospects.toggle(prospect)
            }
            if !prospect.isContacted {
                Button("Remind me") {
                    addNotification(for: prospect)
                }
            }
        }
    }
}

extension ProspectRow {
    func addNotification(for prospect: Prospect) {
        let center = UNUserNotificationCenter.current()
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.title = "Contact \(prospect.name)"
            content.subtitle = prospect.emailAddress
            content.sound = UNNotificationSound.default
            
            var dateComponents = DateComponents()
            dateComponents.hour = 9
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: false)
            // use below for testing
//            let trigger = UNTimeIntervalNotificationTrigger(timeInterval: 5, repeats: false)
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            if settings.authorizationStatus == .authorized {
                addRequest()
                return
            }
            center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                if success {
                    addRequest()
                } else {
                    print("Error requesting authorization")
                }
            }
        }
        
    }
}

struct ProspectRow_Previews: PreviewProvider {
    static var previews: some View {
        ProspectRow(prospect: Prospect())
    }
}
