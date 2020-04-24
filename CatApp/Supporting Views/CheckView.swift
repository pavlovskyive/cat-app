//
//  CheckView.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 23.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct CheckView: View {
    @ObservedObject var type: Type
    
    var body: some View {
        VStack {
            Toggle(isOn: $type.state) {
                Text(self.type.title)
            }
        }
        //.padding()
//        .clipped()
//        .background(
//            Color.primary.colorInvert()
//                .cornerRadius(10)
//                .shadow(radius: 1)
//        )
    }
}
