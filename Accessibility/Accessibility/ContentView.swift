//
//  ContentView.swift
//  Accessibility
//
//  Created by Tino on 6/4/21.
//

import SwiftUI

struct ContentView: View {
    static let range = 0..<3
    
    let names = [
        "ales-krivec-15949",
        "galina-n-189483",
        "kevin-horstmann-141705",
        "nicolas-tissot-335096",
    ]
    
    @State private var randomIndex = Int.random(in: Self.range)
    
    var body: some View {
        VStack {
            Image(names[randomIndex])
                .resizable()
                .scaledToFit()
                .onTapGesture {
                    randomIndex = Int.random(in: Self.range)
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
