//
//  TabView.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct NavigationLinkButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .scaleEffect(configuration.isPressed ? 0.9 : 1)
            .animation(.spring())
    }
}

struct TabsView: View {
    
    var body: some View {
        VStack {
            HStack(spacing: 30) {
                NavigationLink(destination: Breeds()) {
                    Tab(imageName: "Cat1", tabText: "Breeds")
                }
                
                NavigationLink(destination: Quiz()) {
                    Tab(imageName: "Cat2", tabText: "Quiz")
                }
            }
            HStack(spacing: 30) {
                NavigationLink(destination: Test()) {
                    Tab(imageName: "Cat3", tabText: "Cat for you")
                }
                
                NavigationLink(destination: About()) {
                    Tab(imageName: "Cat4", tabText: "About")
                }
            }
        }.buttonStyle(NavigationLinkButtonStyle())
    }
}

struct TabsView_Previews: PreviewProvider {
    static var previews: some View {
        TabsView()
    }
}
