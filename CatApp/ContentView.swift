//
//  ContentView.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @EnvironmentObject var networkManager: NetworkManager
    
    var body: some View {
        NavigationView {
            TabsView()
                .padding()
                .navigationBarTitle("Home")
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView().environmentObject(NetworkManager())
    }
}
