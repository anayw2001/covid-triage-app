//
//  ContentView.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/24/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView {
            VStack {
                Text("Hello! Would you like to get tested?").font(.title)
                Spacer().frame(height: 100)
                NavigationLink(destination: q1()) {
                    VStack {
                        Text("Tap here to begin.")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(40)
                    }
                }
            }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
