//
//  NearbyList.swift
//  BucketList
//
//  Created by Tino on 1/5/21.
//

import SwiftUI

struct NearbyList: View {
    
    let url = URL(string: "https://images.unsplash.com/photo-1619720655461-ba20fa0cfec9?ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&ixlib=rb-1.2.1&auto=format&fit=crop&w=691&q=80")!
    
    let pages: [Page]
    
    var body: some View {
        List {
            ForEach(pages) { page in
                HStack {
                    if page.thumbnailURL != nil {
                        if page.thumbnailURL != nil {
                            AsyncImage(url: URL(string: page.thumbnailURL!)!) {
                                Text("loading ...")
                            }
                            .scaledToFill()
                            .frame(width: 60, height: 60)
                            .cornerRadius(10)
                        }
                    }
                    VStack(alignment: .leading) {
                        Text(page.title)
                            .font(.headline)
                        Spacer()
                        Text(page.description)
                            .font(.subheadline)
                            .foregroundColor(.secondary)
                    }
                }
            }
        }
    }
}

struct NearbyList_Previews: PreviewProvider {
    static var previews: some View {
        NearbyList(pages: [])
    }
}
