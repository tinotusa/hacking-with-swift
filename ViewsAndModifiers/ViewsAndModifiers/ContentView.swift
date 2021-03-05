//
//  ContentView.swift
//  ViewsAndModifiers
//
//  Created by Tino on 5/3/21.
//

import SwiftUI

struct ContentView: View {
    @State private var text = ""
    
    var body: some View {
        VStack {
            SearchBar(placeholderText: "Search", text: $text) {
                print("Search was pressed")
            }
            Text(textEntered)
                .largeBlueFont()
        }
        .padding()
    }
    
    var textEntered: String {
        if text.isEmpty {
            return "Enter some text"
        }
        return text
    }
}

// Challenge 1
struct LargeBlueFont: ViewModifier {
    func body(content: Content) -> some View {
        content
            .font(.largeTitle)
            .foregroundColor(.blue)
    }
    
}

extension View {
    func largeBlueFont() -> some View {
        self.modifier(LargeBlueFont())
    }
}

// view composition
struct SearchBar: View {
    let placeholderText: String
    @Binding var text: String
    let action: () -> Void
    
    var body: some View {
        HStack(spacing: 10) {
            TextField(placeholderText, text: $text)
                .padding()
            Button(action: action) {
                Image(systemName: "magnifyingglass")
                    .renderingMode(.original)
                    .font(.title)
            }
        }
        .padding(.horizontal)
        .background(Color.gray)
        .opacity(0.4)
        .clipShape(RoundedRectangle(cornerRadius: 10))
        .overlay(RoundedRectangle(cornerRadius: 10).stroke(Color.gray, lineWidth: 1))
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
