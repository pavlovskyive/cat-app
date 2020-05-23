//
//  CheckView.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 23.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

struct CustomToggleStyle: ToggleStyle {
    
    func makeBody(configuration: Configuration) -> some View {
        return HStack {
            configuration.label
            Spacer()
        }
        .padding()
        .background(Color(configuration.isOn ? .systemTeal : .systemGray6))
        .foregroundColor(configuration.isOn ? .white : .primary)
        .cornerRadius(8)
        .offset(x: configuration.isOn ? 5 : 0)
        .onTapGesture {
            configuration.isOn.toggle()
        }
        .animation(.spring())
    }
}

struct CheckView: View {
    @ObservedObject var type: Type
    
    var body: some View {
        VStack {
            Toggle(isOn: $type.state) {
                Text(self.type.title)
                    .font(.system(size: 20))
                    .animation(nil)
            }
            .toggleStyle(CustomToggleStyle())
        }
    }
}

struct CheckView_Previews: PreviewProvider {
    static var previews: some View {
        CheckView(type: Type(title: "active", state: false))
    }
}
