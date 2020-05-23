//
//  TabView.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct TabButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.95 : 1)
            .animation(.spring())
    }
}

struct TabsView: View {
    
    var body: some View {
        VStack {
            NavigationLink(destination: Test()) {
                Tab(imageName: "Cat3", tabText: "Cat for you")
            }

            HStack(spacing: 30) {
                NavigationLink(destination: Breeds()) {
                    Tab(imageName: "Cat1", tabText: "Breeds")
                }
                
                NavigationLink(destination: About()) {
                    Tab(imageName: "Cat4", tabText: "About")
                }
            }
        }.buttonStyle(TabButtonStyle())
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
