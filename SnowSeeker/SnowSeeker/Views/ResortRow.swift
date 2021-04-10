//
//  ResortRow.swift
//  SnowSeeker
//
//  Created by Tino on 10/4/21.
//

import SwiftUI

struct ResortRow: View {
    let resort: Resort
    let cornerRadiusSize = CGFloat(5)
    
    var body: some View {
        HStack {
            Image(resort.country)
                .resizable()
                .scaledToFit()
                .frame(width: 40, height: 25)
                .clipShape(
                    RoundedRectangle(cornerRadius: cornerRadiusSize)
                )
                .overlay(
                    RoundedRectangle(cornerRadius: cornerRadiusSize)
                        .stroke(Color.black, lineWidth: 1)
                )
            VStack(alignment: .leading) {
                Text(resort.name)
                    .font(.headline)
                Text("\(resort.runs) runs")
                    .foregroundColor(.secondary)
            }
        }
    }
}

struct ResortRow_Previews: PreviewProvider {
    static var previews: some View {
        ResortRow(resort: Resort.example)
    }
}
