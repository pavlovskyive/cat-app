//
//  Test.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

// Desribing style of toggle
struct BlueToggleStyle: ToggleStyle {

    // 'makeBody' is needed to conform to protocol ToggleStyle.
    //
    // Configuration has isOn variable which we are depending on
    // in order to make visual difference when toggle is "on" or "off"
    // via changing background and foreground color.
    func makeBody(configuration: Configuration) -> some View {
        
        // Simply telling that label for toggle title will pushed
        // to the left
        return HStack {
            configuration.label
            Spacer()
        }
        .padding()
        .background(Color(configuration.isOn ? .systemTeal : .systemGray6))
        .foregroundColor(configuration.isOn ? .white : .primary)
        .cornerRadius(8)
        .shadow(color: Color.blue.opacity(configuration.isOn ? 0.33 : 0), radius: 10, x: 0, y: 5)
        .offset(x: configuration.isOn ? 5 : 0)
        .onTapGesture {
            configuration.isOn.toggle()
        }
        .animation(.spring())
    }
}

// Extending Array and adding method which returns version of
// itself without repeating elements.
//
// For using Set() we need to make sure that Element (of an array)
// conforms to protocol Hashable.
extension Array where Element : Hashable {
    var unique: [Element] {
        return Array(Set(self))
    }
}

// Custom Toggle View
struct BlueToggle: View {
    
    // Text of toggle
    var title: String
    
    // changing this will affect @State var enabledTemperaments of parent
    @Binding var enabledTemperaments: Set<String>
    
    // State variable to store state of our toggle
    @State var isToggled = false
    
    var body: some View {
        
        // Creating custom binding.
        // When it will be set, it will insert to parent's 'enabledTemperaments'
        // title of this toggle asynchronously
        let binding = Binding(
            get: {self.isToggled},
            set: {
                self.isToggled = $0
                
                if self.isToggled {
                    self.enabledTemperaments.insert(self.title)
                } else {
                    self.enabledTemperaments.remove(self.title)
                }
            }
        )
        
        // Toggle with our custom binding and style
        return Toggle(isOn: binding) {
            Text(title)
                .font(.system(size: 20))
                .animation(nil)
        }.toggleStyle(BlueToggleStyle())
    }
}

struct Test: View {
    // Subscribed NetworkManager
    @EnvironmentObject var networkManager: NetworkManager
    
    // Bindable Set of strings (Set to make elements unique)
    @State var enabledTemperaments = Set<String>()
    
    var body: some View {
        
        func setTemperaments(breeds: [Breed]) -> some View {
            
            // Creating temp which contains every breed temperament ...
            var temp = [String]()
            breeds.forEach {
                temp.append(contentsOf: $0.temperament.components(separatedBy: ", "))
            }
            
            // ... and returning ScrollView with all of them as toggles.
            return ScrollView(.vertical) {
                ForEach(temp.unique.sorted(), id: \.self) {
                    BlueToggle(title: $0, enabledTemperaments: self.$enabledTemperaments)
                        .padding(.vertical, 5)
                }
                .padding([.horizontal, .bottom])
            }
        }
        
        return
            VStack {
                Text("Choose temperament types which suit you most")
                
                // If is empty put a loading label.
                if !networkManager.breeds.isEmpty {
                    setTemperaments(breeds: networkManager.breeds)
                } else {
                    VStack {
                        Spacer()
                        Text("Loading...")
                            .foregroundColor(.secondary)
                        Spacer()
                    }
                }
                
                NavigationLink(destination: CompareView(enabledTemperaments: Array(self.enabledTemperaments))) {
                    Spacer()
                    Text("Apply").padding(.bottom)
                    Spacer()
                }
                .disabled(enabledTemperaments.isEmpty)
                .padding()
                .foregroundColor(.white)
                .background(Color(!enabledTemperaments.isEmpty ? .systemBlue : .systemGray5))
                .padding(.top, -10)
        }
        .navigationBarTitle("Temperament")
        .edgesIgnoringSafeArea(.bottom)
        .animation(.default)
    }
}

struct Test_Previews: PreviewProvider {
    static var previews: some View {
        Test().environmentObject(NetworkManager())
    }
}
