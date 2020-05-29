//
//  Breeds.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

// Custom button style
struct BreedButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
                .background(Color(configuration.isPressed ? .systemTeal : .systemGray6))
            .foregroundColor(configuration.isPressed ? .white : .primary)
            .cornerRadius(8)
            .offset(x: configuration.isPressed ? 5 : 0)
            .shadow(color: Color.blue.opacity(configuration.isPressed ? 0.33 : 0), radius: 10, x: 0, y: 5)
            .animation(.spring())
    }
}

struct Breeds: View {
    @EnvironmentObject var networkManager: NetworkManager
    
    var body: some View {
        VStack {
            // if data is loaded
            if !networkManager.breeds.isEmpty {
                ScrollView(.vertical) {
                    // for each breed created link to its detailed view
                    ForEach(networkManager.breeds, id: \.id) { breed in
                        NavigationLink(destination: BreedDetail(breed: breed)) {
                            HStack {
                                Text(breed.name)
                                    .animation(nil)
                                Spacer()
                            }
                            .padding()
                        }
                        .padding(.horizontal, 15)
                        .padding(.vertical, 5)
                        .buttonStyle(BreedButtonStyle())
                    }
                }
                // remove separator from list
                .listSeparatorStyle(style: .none)
            } else {
                Text("Loading...")
                    .foregroundColor(.secondary)
            }
        }
        .navigationBarTitle(Text("Breeds"))
    }
}

// View Modifier removing separator
struct ListSeparatorStyle: ViewModifier {
    let style: UITableViewCell.SeparatorStyle
    
    func body(content: Content) -> some View {
        content
            .onAppear() {
                UITableView.appearance().separatorStyle = self.style
            }
    }
}
 
// Extending View struct to add style simply as method
extension View {
    func listSeparatorStyle(style: UITableViewCell.SeparatorStyle) -> some View {
        ModifiedContent(content: self, modifier: ListSeparatorStyle(style: style))
    }
}

// Will not be in final program
struct Breeds_Previews: PreviewProvider {
    static var previews: some View {
        Breeds().environmentObject(NetworkManager())
    }
}
