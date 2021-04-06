//
//  EditView.swift
//  BucketList
//
//  Created by Tino on 6/4/21.
//

import SwiftUI
import MapKit

struct EditView: View {
    @Environment(\.presentationMode) var presentationMode
    @ObservedObject var placemark: MKPointAnnotation
    
    enum LoadingState {
        case loading, loaded, failed
    }
    @State private var loadingState = LoadingState.loading
    @State private var pages = [Page]()
    
    var body: some View {
        NavigationView {
            Form {
                Section {
                    TextField("Place name", text: $placemark.wrappedTitle)
                    TextField("Description", text: $placemark.wrappedSubtitle)
                }
                
                Section(header: Text("Nearby...")) {
                    switch loadingState {
                    case .loaded:
                        List(pages, id: \.pageID) { page in
                            Text(page.title)
                                .font(.headline)
                            + Text(": ") +
                            Text(page.description)
                                .italic()
                        }
                    case .loading:
                        Text("Loading...")
                    case .failed:
                        Text("Please try again later")
                    }
                }
            }
            .navigationBarTitle("Edit place")
            .navigationBarItems(trailing: Button("Done", action: closeView))
        }
        .onAppear {
            fetchNearbyPlaces { result in
                switch result {
                case .failure(let error):
                    print(error)
                case .success(let pages):
                    self.pages = pages
                }
            }
        }
    }
    
    func closeView() {
        presentationMode.wrappedValue.dismiss()
    }
    
}

// MARK: Network
extension EditView {
    enum NetworkError: Error {
        case error(String)
    }
    
    func fetchNearbyPlaces(completion: @escaping ((Result<[Page], NetworkError>) -> Void)) {
        var urlComponents = URLComponents()
        urlComponents.scheme = "https"
        urlComponents.host = "en.wikipedia.org"
        urlComponents.path = "/w/api.php"
        urlComponents.queryItems = [
            URLQueryItem(name: "ggscoord", value: "\(placemark.coordinate.latitude)|\(placemark.coordinate.longitude)"),
            URLQueryItem(name: "action", value: "query"),
            URLQueryItem(name: "prop", value: "coordinates|pageiamges|pageterms"),
            URLQueryItem(name: "colimit", value: "50"),
            URLQueryItem(name: "piprop", value: "thumbnail"),
            URLQueryItem(name: "pithumbsize", value: "500"),
            URLQueryItem(name: "pilimit", value: "50"),
            URLQueryItem(name: "wbptterms", value: "description"),
            URLQueryItem(name: "generator", value: "geosearch"),
            URLQueryItem(name: "ggradius", value: "10000"),
            URLQueryItem(name: "ggslimit", value: "50"),
            URLQueryItem(name: "format", value: "json")
        ]
        guard let url = urlComponents.url else {
            print("Bad URL: \(urlComponents.url?.description ?? "no url string")")
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error as NSError? {
                DispatchQueue.main.async {
                    loadingState = .failed
                    completion(.failure(.error(error.localizedDescription)))
                }
                return
            }
            guard let data = data else {
                print("no data")
                return
            }
            let decoder = JSONDecoder()
            do {
                let decodedData = try decoder.decode(WikipediaResult.self, from: data)
                let pages = Array(decodedData.query.pages.values).sorted()
                DispatchQueue.main.async {
                    loadingState = .loaded
                    completion(.success(pages))
                }
            } catch {
                DispatchQueue.main.async {
                    completion(.failure(.error("testing" + error.localizedDescription)))
                }
            }
        }
        
        task.resume()
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(placemark: MKPointAnnotation.example)
    }
}
