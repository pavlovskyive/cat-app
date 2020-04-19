//
//  Data.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI
import CoreLocation

struct Item: Hashable, Codable, Identifiable {
    var id: String
    var name: String
}

//let itemsData: [Item] = load("https://api.thecatapi.com/v1/breeds")

/*
func load<T: Decodable>(_ url: String) -> [T] {
    var items: [T] = []
    
    guard let url = URL(string: url)
        else {
            fatalError("Couldn't unwrap url")
    }
    print()
    
    URLSession.shared.dataTask(with: url) { (data, _, _) in
        items = try! JSONDecoder().decode([T].self, from: data!)
    }
    print(items)
    return items
}
*/

class NetworkManager {
    func fetchItems(completionHandler: @escaping ([Item]) -> Void) {
      let url = URL(string: "https://api.thecatapi.com/v1/breeds")!

      let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
        if let error = error {
          print("Error with fetching data: \(error)")
          return
        }
        
        guard let httpResponse = response as? HTTPURLResponse,
              (200...299).contains(httpResponse.statusCode) else {
                print("Error with the response, unexpected status code: \(String(describing: response))")
          return
        }

        if let data = data,
            let items = try? JSONDecoder().decode([Item].self, from: data) {
                DispatchQueue.main.async {
                    completionHandler(items)
                }
            }
        })
        task.resume()
    }
}
