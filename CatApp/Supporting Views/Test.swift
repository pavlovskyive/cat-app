//
//  Test.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

final class Type: ObservableObject, Identifiable, Comparable{
    static func < (lhs: Type, rhs: Type) -> Bool {
        lhs.title < rhs.title
    }

    static func == (lhs: Type, rhs: Type) -> Bool {
        return false
    }
    
    var id = UUID()
    @Published var title: String
    @Published var state: Bool
    
    init(title: String, state: Bool) {
        self.title = title
        self.state = state
    }
}

final class TemperamentTypes: ObservableObject {
    @Published var types: [Type]
    
    init(_ types: [Type]) {
        self.types = types
    }
}

struct Test: View {
    @ObservedObject var temperamentTypes = TemperamentTypes([
        Type(title: "Active", state: false),
        Type(title: "Affectionate", state: false),
        Type(title: "Social", state: false),
        Type(title: "Energetic", state: false),
        Type(title: "Independent", state: false),
        Type(title: "Intelligent", state: false),
        Type(title: "Gentle", state: false),
        Type(title: "Playful", state: false),
        Type(title: "Interactive", state: false),
        Type(title: "Sensitive", state: false),
        Type(title: "Curious", state: false),
        Type(title: "Easy Going", state: false),
        Type(title: "Calm", state: false),
        Type(title: "Loyal", state: false),
        Type(title: "Agile", state: false),
        Type(title: "Fun-loving", state: false),
        Type(title: "Relaxed", state: false),
        Type(title: "Friendly", state: false),
        Type(title: "Demanding", state: false),
        Type(title: "Alert", state: false),
        Type(title: "Dependent", state: false),
        Type(title: "Patient", state: false),
    ])
    
    var body: some View {
        VStack {
            Text("Choose temperament types which suit you most")
            
            ScrollView(.vertical) {
                ForEach(temperamentTypes.types.sorted(), id: \.id) { type in
                    CheckView(type: type)
                        .padding(.vertical, 5)
                }
                .padding(.horizontal, 15)
            }

            NavigationLink(destination: CompareView(temperamentTypes: temperamentTypes.types)) {
                Spacer()
                Text("Apply")
                    .font(.system(size: 20))
                Spacer()
            }
            .padding(.bottom, 30)
            .padding(.top)
            .foregroundColor(.white)
            .background(Color(.systemBlue))
        }
        .navigationBarTitle("Temperament")
        .edgesIgnoringSafeArea(.bottom)
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test()
    }
}
