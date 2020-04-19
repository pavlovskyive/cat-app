//
//  UserData.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI
import Combine

final class UserData: ObservableObject {
    @Published var items: [Item] = []
    
    init() {
        NetworkManager().fetchItems { (items) in
            print(items)
            self.items = items
        }
    }
}

