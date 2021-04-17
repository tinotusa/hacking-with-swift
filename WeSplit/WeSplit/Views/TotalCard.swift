//
//  TotalCard.swift
//  WeSplit
//
//  Created by Tino on 17/4/21.
//

import SwiftUI

struct TotalCard: View {
    var header: String
    let text: String
    
    init(_ header: String = "", text: String) {
        self.header = header
        self.text = text
    }
    
    var body: some View {
        ZStack {
            Color("blue")
            VStack(alignment: .center) {
                Text(header)
                    .foregroundColor(.white)
                Text(text)
                    .foregroundColor(Color("orange"))
            }
            .font(.system(size: 50))
        }
        .cornerRadius(20)
    }
}


struct TotalCard_Previews: PreviewProvider {
    static var previews: some View {
        TotalCard("hello, world", text: "some text")
    }
}
