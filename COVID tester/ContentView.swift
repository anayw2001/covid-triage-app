//
//  ContentView.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/24/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct LazyView<Content: View>: View {
    let build: () -> Content
    init(_ build: @autoclosure @escaping () -> Content) {
        self.build = build
    }
    var body: Content {
        build()
    }
}

struct ContentView: View {
    @State var isActiveTest : Bool = false
    @State var isActiveIsolation : Bool = false
    var body: some View {
        NavigationView {
            VStack {
                Text("Let's see if your patient needs testing!").font(.title).padding(.horizontal, 15.0)
                Spacer().frame(height: 50)
                NavigationLink(destination: q1(rootIsActive: $isActiveTest), isActive: self.$isActiveTest) {
                    VStack {
                        Text("Tap here to begin testing.")
                            .font(.title)
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(40)
                    }
                }
                Spacer().frame(height: 50)
                NavigationLink(destination: IsolationGridQuestion(rootIsActive: $isActiveIsolation), isActive: self.$isActiveIsolation) {
                    VStack {
                        Text("Tap here to access the isolation grid.")
                            .font(.title)
                            .multilineTextAlignment(.center)
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
