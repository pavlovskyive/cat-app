//
//  Vote.swift
//  CatApp
//
//  Created by Vsevolod Pavlovskyi on 19.04.2020.
//  Copyright © 2020 Vsevolod Pavlovskyi. All rights reserved.
//

import SwiftUI

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
