//
//  CompareView.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 24.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct RowView: View {
    var text: String
    
    var body: some View {
        HStack {
            Text(text)
            Spacer()
            Image(systemName: "chevron.right")
        }
    }
}

struct CompareView: View {
    @EnvironmentObject var userData: UserData
    
    var temperamentTypes: [Type]
    
    private var choosedTypes: [String] {
        temperamentTypes.filter( {$0.state == true} ).map( {return $0.title} )
    }
    
    var suitableBreeds: [Breed] {
        var finalArray: [Breed] = []
        //TODO:
        // Compare every breed with current and +
        // store in temp dictionary count of same elements. +
        //
        // pop best, pop second best, pop third best
        // return 3 best results
        
        var sameElements: [Breed: Int] = [:]
        userData.breeds.forEach { breed in
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
                        .font(.subheadline)
                    
                    Text(choosedTypes.joined(separator: ", "))
                        .font(.system(size: 20)).lineLimit(nil)
                }
                Spacer()
            }
            
            Text("Most suitable breeds are:").bold()
            VStack {
                ForEach(suitableBreeds) { breed in
                    NavigationLink(destination: BreedDetail(breed: breed)) {
                        RowView(text: breed.name)
                            .font(.system(size: 20))
                    }
                    Divider()
                }
            }
            Spacer()
        }
        .navigationBarTitle("Cat for you")
        .padding()
    }
}

struct CompareView_Previews: PreviewProvider {
    static var previews: some View {
        CompareView(temperamentTypes: [Type(title: "Active", state: true), Type(title: "Energetic", state: false), Type(title: "Friendly", state: true)]).environmentObject(UserData())
    }
}
