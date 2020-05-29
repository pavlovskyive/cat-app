//
//  NetworkManager.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 13.05.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//
import Foundation
import Combine

class NetworkManager: ObservableObject {
    // url from which we will fetch вфеф
    var hostUrl = "https://morning-ridge-19579.herokuapp.com/api/breeds"
    
    // Send updates forcing Views to update their contents
    var didChange = PassthroughSubject<NetworkManager, Never>()
    
    // When will be loaded send notification to every View subscribed to NetworkManager
    @Published var breeds = [Breed]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        guard let url = URL(string: hostUrl) else { return }
        
        // Start URLSession fetching data from url
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            
            // if data is still optional (nil) return
            guard let data = data else { return }
            
            // try decoding
            if let items = try? JSONDecoder().decode([Breed].self, from: data) {
                
                // Put to background. When done -- interrupt main thread
                DispatchQueue.main.async {
                    self.breeds = items
                }
            }
        }.resume()
    }
}

// Same as above but for image
class ImageLoader: ObservableObject {
    var hostUrl = "https://morning-ridge-19579.herokuapp.com/api/images?breed_id="
    
    var didChange = PassthroughSubject<Data, Never>()
    
    @Published var data = Data() {
        didSet {
            didChange.send(data)
        }
    }
    
    init(query: String) {
        guard let url = URL(string: hostUrl + query) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self.data = data
                }
            }
        }.resume()
    }
}

// Struct representing how data from JSON looks like to be parsed.
struct Breed: Hashable, Codable, Identifiable {
    var description: String
    var id: String
    var life_span: String
    var name: String
    var origin: String
    var temperament: String
}
