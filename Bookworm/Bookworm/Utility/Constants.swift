//
//  Constants.swift
//  Bookworm
//
//  Created by Tino on 26/4/21.
//

import SwiftUI
import CoreData

struct Constants {
    static var bookWidth: CGFloat = 120
    static var bookHeight: CGFloat = 160
    
    static func saveContext(_ context: NSManagedObjectContext, shouldAnimate: Bool = true) {
        if context.hasChanges {
            if shouldAnimate {
                do {
                    try withAnimation {
                        try context.save()
                    }
                } catch {
                    print("Failed to save context\n\(error.localizedDescription)")
                }
            } else {
                do {
                    try context.save()
                } catch {
                    print("Failed to save context\n\(error.localizedDescription)")
                }
            }
        }
    }
}
