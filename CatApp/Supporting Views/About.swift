//
//  Vote.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

// Simple View with text and URL to Git
// On tap open link in defauld browser
struct About: View {
    var body: some View {
        VStack(spacing: 10) {
            Text("Designed by Vsevolod Pavlovskyi")
             Text("GitHub Link")
                .foregroundColor(.blue)
                .onTapGesture {
                    let url = URL.init(string: "https://github.com/pavlovskyive/cat-app")
                    UIApplication.shared.open(url!)
            }
        }
    }
}

struct About_Previews: PreviewProvider {
    static var previews: some View {
        About()
    }
}
