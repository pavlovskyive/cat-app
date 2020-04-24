//
//  Breeds.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct Breeds: View {
    @EnvironmentObject var userData: UserData
    
    var body: some View {
        List {
            ForEach(userData.breeds) { breed in
                NavigationLink(destination: BreedDetail(breed: breed)) {
                    Text(breed.name)
                }
            }
        }
        .navigationBarTitle(Text("Breeds"))
    }
}

struct Breeds_Previews: PreviewProvider {
    static var previews: some View {
        Breeds().environmentObject(UserData())
    }
}
