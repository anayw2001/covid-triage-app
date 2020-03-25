//
//  ContentView.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/24/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI


struct YesNoView: View {
    var body: some View {
        VStack {
            HStack {
                Button(action: {
                    print("Yes")
                }) {
                    Text("Yes")
                        .fontWeight(.bold)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.blue
                            .buttonStyle(/*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Button Style@*/DefaultButtonStyle()/*@END_MENU_TOKEN@*/))
                        .foregroundColor(.white)
                        .padding(10)
                }
                Spacer()
                Button(action: {
                    print("No")
                }) {
                    Text("No")
                        .fontWeight(.bold)
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.blue
                            .buttonStyle(/*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Button Style@*/DefaultButtonStyle()/*@END_MENU_TOKEN@*/))
                        .foregroundColor(.white)
                        .padding(10)
                }
            }
            Spacer()
        }
    }
}


struct ContentView: View {
    var body: some View {
        Button(action: {
            print("tapped")
        }) {
            Text("Hello! Would you like to start testing?")
                .fontWeight(.bold)
                .font(.title)
                .multilineTextAlignment(.center)
                .padding()
                .background(Color.blue
                    .buttonStyle(/*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Button Style@*/DefaultButtonStyle()/*@END_MENU_TOKEN@*/))
                .foregroundColor(.white)
                .padding(10)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
