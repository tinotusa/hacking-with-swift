//
//  ImageLoader.swift
//  BucketList
//
//  Created by Tino on 29/4/21.
//

import SwiftUI
import Combine

// this is broken somehow
class ImageLoader: ObservableObject {
    @Published var image: UIImage?
    private let url: URL
    private var cancellable: AnyCancellable?
    
    init(url: URL) {
        self.url = url
    }
    
    deinit {
        cancel()
    }
    
    func load() {
        cancellable = URLSession.shared.dataTaskPublisher(for: url)
            .map { UIImage(data: $0.data) }
            .replaceError(with: nil)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] in self?.image = $0 }
    }
    
    func cancel() {
        cancellable?.cancel()
    }
}
