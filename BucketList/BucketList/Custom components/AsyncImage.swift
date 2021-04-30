//
//  AsyncImage.swift
//  BucketList
//
//  Created by Tino on 30/4/21.
//

import SwiftUI

struct AsyncImage<Placeholder: View>: View {
    @StateObject private var loader: ImageLoader
    private let placeholder: Placeholder
    
    init(url: URL, @ViewBuilder placeholder: () -> Placeholder) {
        self.placeholder = placeholder()
        _loader = StateObject(wrappedValue: ImageLoader(url: url))
    }
    
    var body: some View {
        content
            .onAppear(perform: loader.load)
    }
    
    private var content: some View {
        Group {
            if loader.image != nil {
                Image(uiImage: loader.image!)
                    .resizable()
            } else {
                placeholder
            }
        }
    }
}

struct AsyncImage_Previews: PreviewProvider {
    static var previews: some View {
        AsyncImage(url: URL(string: "somelinkhere")!, placeholder: {Text("loading...")})
    }
}
