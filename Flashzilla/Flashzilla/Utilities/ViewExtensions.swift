//
//  ViewExtensions.swift
//  Flashzilla
//
//  Created by Tino on 2/9/21.
//

import SwiftUI

extension View {
    func appEnteredBackground(_ action: (() -> Void)?) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                action?()
            }
    }
    
    func appEnteredForeground(_ action: (() -> Void)?) -> some View {
        self
            .onReceive(NotificationCenter.default.publisher(for: UIApplication.didBecomeActiveNotification)) { _ in
                action?()
            }
    }
}

struct Stacked: ViewModifier {
    /// The index of the thing currently being stacked.
    let index: Int
    /// The total size of the stack.
    let total: Int
    /// The amount to offset the "deck of things".
    let offsetAmount = 5
    
    func body(content: Content) -> some View {
        content
            .offset(x: CGFloat((total - index) * 3), y: CGFloat(total - index * offsetAmount))
    }
}

extension View {
    func stacked(index: Int, total: Int) -> some View {
        self.modifier(Stacked(index: index, total: total))
    }
}


struct Dismissable: ViewModifier {
    var dismiss: (() -> Void)?
    
    func body(content: Content) -> some View {
        NavigationView {
            content
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Close") {
                            dismiss?()
                        }
                    }
                }
        }
    }
}

extension View {
    func dismissable(_ dismiss: (() -> Void)?) -> some View {
        self.modifier(Dismissable(dismiss: dismiss))
    }
}
