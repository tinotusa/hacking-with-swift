//
//  FloatingButton.swift
//  BucketList
//
//  Created by Tino on 6/4/21.
//

import SwiftUI

struct FloatingButton: View {
    let action: () -> Void
    
    var body: some View {
        VStack {
            Spacer()
            HStack() {
                Spacer()
                Button(action: action) {
                    Image(systemName: "plus")
                        .padding()
                        .background(
                            Color.black
                                .opacity(0.75)
                        )
                        .foregroundColor(.white)
                        .font(.title)
                        .clipShape(Circle())
                        .padding(.trailing)
                }
            }
        }
    }
}

struct FloatingButton_Previews: PreviewProvider {
    static var previews: some View {
        FloatingButton() {}
    }
}
