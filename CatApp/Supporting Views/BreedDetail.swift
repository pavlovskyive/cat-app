//
//  BreedDetail.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 20.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct BreedDetail: View {
    var breed: Breed
    
    var body: some View {
        List {
            VStack(alignment: .leading, spacing: 20) {
                ImageView(query: breed.id)

                CardView(header: "", text: breed.description)
                    
                CardView(header: "Origin", text: self.breed.origin)
                    
                CardView(header: "Life Span", text: String(self.breed.life_span + " years"))
                    
                CardView(header: "Temperament", text: self.breed.temperament)
            }
            .fixedSize(horizontal: false, vertical: true)
            .animation(.default)
        }
        .onAppear(){
            UITableView.appearance().separatorStyle = .none
        }
        .navigationBarTitle(breed.name)
        .edgesIgnoringSafeArea(.horizontal)
    }
}

struct CardView: View {
    var header: String
    var text: String
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 2) {
                if (!header.isEmpty) {
                    Text(header)
                        .bold()
                }
                Text(text)
                    .font(Font.system(size: 20, weight: Font.Weight.light))
                    .animation(nil)
                    .fixedSize(horizontal: false, vertical: true)
            }
            .animation(nil)
            if (!header.isEmpty) {
                Spacer()
            }
        }
        .padding()
        .background(Color(.systemGray6))
        .cornerRadius(8)
    }
}

// Load image from url
struct ImageView: View {
    @ObservedObject var imageLoader: ImageLoader
    
    init(query: String) {
        imageLoader = ImageLoader(query: query)
    }
    
    var body: some View {
        VStack {
            // if we have some data then put image from data
            if (imageLoader.data.count != 0) {
                Image(uiImage: UIImage(data: imageLoader.data)!)
                    .resizable()
                    .scaledToFit()
                    .clipped()
                    .cornerRadius(8)
            }
        }
    }
}

struct BreedDetail_Previews: PreviewProvider {
    static var previews: some View {
        BreedDetail(breed: Breed(description: "The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals. The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals. The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals. The Abyssinian is easy to care for, and a joy to have in your home. They’re affectionate cats and love both people and other animals.", id: "abys", life_span: "14 - 15", name: "Abyssian", origin: "Egypt", temperament: "Active, Energetic, Independent, Intelligent, Gentle"))
    }
}

