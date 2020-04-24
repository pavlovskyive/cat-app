//
//  BreedDetail.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 20.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct BreedDetail: View {
    @ObservedObject var networkManager: NetworkManager
    var breed: Breed
    
    struct Detailed: Codable {
        var id: String
        //var name: String
        var url: String
    }
    
    func getUrlFromData(data: Data?) -> String {
        if let data = data,
        let items = try? JSONDecoder().decode([Detailed].self, from: data) {
            return items[0].url
        } else { return "" }
    }
    
    init(breed: Breed) {
        networkManager = NetworkManager(urlString: "https://api.thecatapi.com/v1/images/search?breed_id=\(breed.id)")
        self.breed = breed
    }
    
    var body: some View {
        ScrollView {
            VStack (alignment: .leading, spacing: 20){
                ImageView(withURL: getUrlFromData(data: networkManager.data))
                    //.shadow(color: Color(.systemGray4), radius: 2, x: 0, y: 2)
                
                Text(breed.description)
                    .font(.body)
                    .lineLimit(nil)
                    .padding([.top, .horizontal])
                    
                VStack(alignment: .leading) {
                    Text("Origin").font(.subheadline)
                    Text(self.breed.origin).font(.headline)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Life Span").font(.subheadline)
                    Text(self.breed.life_span).font(.headline)
                }
                .padding(.horizontal)
                
                VStack(alignment: .leading) {
                    Text("Temperament").font(.subheadline)
                    Text(self.breed.temperament).font(.headline)
                }
                .padding(.horizontal)
            }
            .padding()
            .navigationBarTitle(breed.name)
        }
    }
}

struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    @State var image:UIImage = UIImage()

    init(withURL url:String) {
        imageLoader = ImageLoader(urlString:url)
    }

    var body: some View {
        VStack {
            Image(uiImage: (self.imageLoader.data != nil ? UIImage(data:self.imageLoader.data!)! : UIImage(named: "placeholder")!))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipped()
            .cornerRadius(5)
            .animation(.easeOut)
        }
    }
}


class ImageLoader: ObservableObject {
    @Published var data:Data?

    init(urlString:String) {
        guard let url = URL(string: urlString) else { return }
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            guard let data = data else { return }
            DispatchQueue.main.async {
                self.data = data
            }
        }
        task.resume()
    }
}

struct BreedDetail_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetail(breed: Breed(description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.", id: "abys", life_span: "14 - 15", name: "Abyssian", origin: "Egypt", temperament: "Active, Energetic, Independent, Intelligent, Gentle"))
    }
}

