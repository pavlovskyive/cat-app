//
//  Tab.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct Tab: View {    
    private var imageName: String
    private var tabText: String
    
    init(imageName: String, tabText: String) {
        self.imageName = imageName
        self.tabText = tabText
    }
    
    var body: some View {
        VStack(alignment: .leading) {
            Image(imageName)
                .resizable()
                .renderingMode(.original)
                .scaledToFit()
                .cornerRadius(10)
                
            Text(tabText)
                .font(.headline)
                .foregroundColor(.primary)
        }
    }
}

struct Tab_Previews: PreviewProvider {
    static var previews: some View {
        Tab(imageName: "Cat1", tabText: "Breeds")
    }
}
