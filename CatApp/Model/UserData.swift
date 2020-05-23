////
////  UserData.swift
////  CatApp
////
////  Created by Vsevolod Pavlovskyi on 19.04.2020.
////  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
////
//
//import SwiftUI
//import Combine
//
//final class UserData: ObservableObject {
//    @Published var breeds: [Breed] = []
//
//    init() {
//        NetworkManager(urlString: "").fetch(query: "breeds"){ (breeds: [Breed]) in
//            self.breeds = breeds
//        }
//    }
//}
//
