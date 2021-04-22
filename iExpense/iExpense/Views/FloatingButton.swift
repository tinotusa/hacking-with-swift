//
//  FloatingButton.swift
//  iExpense
//
//  Created by Tino on 22/4/21.
//

import SwiftUI


struct FloatingButton: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack {
                Spacer()
                Button(action: action) {
                    buttonImage
                }
            }
        }
    }
    
    var buttonImage: some View {
        Image(systemName: "plus")
            .font(.largeTitle)
            .foregroundColor(.white)
            .frame(width: 80, height: 80)
            .background(Color("red"))
            .clipShape(Circle())
            .shadow(radius: 10)
    }
}
struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton() {}
    }
}
