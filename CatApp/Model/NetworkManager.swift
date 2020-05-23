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
    var hostUrl = "https://morning-ridge-19579.herokuapp.com/api/breeds"
    
    var didChange = PassthroughSubject<NetworkManager, Never>()
    
    @Published var breeds = [Breed]() {
        didSet {
            didChange.send(self)
        }
    }
    
    init() {
        guard let url = URL(string: hostUrl) else { return }
        
        URLSession.shared.dataTask(with: url) {(data, _, _) in
            
            guard let data = data else { return }
            
            if let items = try? JSONDecoder().decode([Breed].self, from: data) {
                DispatchQueue.main.async {
                    self.breeds = items
                }
            }
        }.resume()
    }
}

class ImageLoader: ObservableObject {
    var hostUrl = "https://morning-ridge-19579.herokuapp.com/api/images?breed_id="
    
    var didChange = PassthroughSubject<Data, Never>()
    
    @Published var data = Data() {
        didSet {
            print("did set called")
            print("data count = " + String(data.count))
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

struct Breed: Hashable, Codable, Identifiable {
    var description: String
    var id: String
    var life_span: String
    var name: String
    var origin: String
    var temperament: String
}
