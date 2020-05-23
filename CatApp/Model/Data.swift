////
////  Data.swift
////  CatApp
////
////  Created by Vsevolod Pavlovskyi on 19.04.2020.
////  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
////
//
//import SwiftUI
//import CoreLocation
//
//class NetworkManager: ObservableObject {
//    @Published var data:Data?
//    
//    init(urlString:String) {
//        guard let url = URL(string: urlString) else { return }
//        let task = URLSession.shared.dataTask(with: url) { data, response, error in
//            guard let data = data else { return }
//            DispatchQueue.main.async {
//                self.data = data
//            }
//        }
//        task.resume()
//    }
//    
//    func fetch<T: Codable>(query: String, completionHandler: @escaping ([T]) -> Void) {
//        let url = URL(string: "https://morning-ridge-19579.herokuapp.com/api/breeds/" + query)!
//
//        let task = URLSession.shared.dataTask(with: url, completionHandler: { (data, response, error) in
//          if let error = error {
//            print("Error with fetching data: \(error)")
//            return
//          }
//          
//          guard let httpResponse = response as? HTTPURLResponse,
//                (200...299).contains(httpResponse.statusCode) else {
//                  print("Error with the response, unexpected status code: \(String(describing: response))")
//            return
//          }
//
//          if let data = data,
//              let items = try? JSONDecoder().decode([T].self, from: data) {
//                  DispatchQueue.main.async {
//                      completionHandler(items)
//                  }
//              }
//          })
//          task.resume()
//     }
//     
//}
//
//struct Breed: Hashable, Codable, Identifiable {
//    var description: String
//    var id: String
//    var life_span: String
//    var name: String
//    var origin: String
//    var temperament: String
//}
//
//struct ImageURL: Codable {
//    var id: String
//    var url: String
//}
