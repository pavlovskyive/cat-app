//
//  CompareView.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 24.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct CompareView: View {
    @EnvironmentObject var networkManager: NetworkManager
    
    var temperamentTypes: [Type]
    
    private var choosedTypes: [String] {
        temperamentTypes.filter( {$0.state == true} ).map( {return $0.title} )
    }
    
    var suitableBreeds: [Breed] {
        var finalArray: [Breed] = []
        
        var sameElements: [Breed: Int] = [:]
        networkManager.breeds.forEach { breed in
            var numberOfSameElements = 0

            breed.temperament.components(separatedBy: ", ").forEach({
                numberOfSameElements += choosedTypes.contains(String($0)) ? 1 : 0})

            sameElements[breed] = numberOfSameElements
        }
        
        for _ in 1...5 {
            if let breed = sameElements.max(by: {lhs, rhs in lhs.value < rhs.value})?.key {
                sameElements.removeValue(forKey: breed)
                finalArray.append(breed)
            }
            
        }
        
        return finalArray
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 30) {

            HStack {
                VStack(alignment: .leading) {
                    Text("You choosed:")
                        .bold()
                    
                    Text(choosedTypes.joined(separator: ", "))
                        .font(Font.system(size: 20, weight: Font.Weight.light))
                        .lineLimit(500)
                }
                Spacer()
            }
            .padding()
            .background(Color(.systemGray6))
            .cornerRadius(8)
            
            VStack (alignment: .leading) {
                Text("Most suitable breeds are:")
                    .font(.title)
                    
                VStack {
                    ForEach(suitableBreeds) { breed in
                        NavigationLink(destination: BreedDetail(breed: breed)) {
                            HStack {
                                Text(breed.name)
                                Spacer()
                            }
                            .padding()
                        }
                        .buttonStyle(BreedButtonStyle())
                        .padding(.top, 15)
                    }
                }
                Spacer()
            }
        }
        .navigationBarTitle("Cat for you")
        .padding()
    }
}

struct CompareView_Previews: PreviewProvider {
    static var previews: some View {
        CompareView(temperamentTypes: [Type(title: "Active", state: true), Type(title: "Energetic", state: false), Type(title: "Friendly", state: true)]).environmentObject(NetworkManager())
    }
}
