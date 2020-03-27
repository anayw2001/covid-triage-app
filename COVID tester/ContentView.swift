//
//  ContentView.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/24/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct ContentView: View {
    @State var isActive : Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Let's see if your patient needs testing!").font(.title)
                Spacer().frame(height: 100)
                NavigationLink(destination: q1(rootIsActive: $isActive), isActive: self.$isActive) {
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
