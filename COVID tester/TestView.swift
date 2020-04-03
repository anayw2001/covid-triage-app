//
//  TestView.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/25/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct TestView: View {
    @Binding var shouldPopToRoot: Bool
    var body: some View {
        VStack {
            ZStack {
                Circle().fill(Color.green).frame(width: 150, height: 150)
                Rectangle().fill(Color.white).frame(width:25, height: 40).rotationEffect(.degrees(-45)).offset(x: -40, y: 10)
                Rectangle().fill(Color.white).frame(width:25, height: 110).rotationEffect(.degrees(45)).offset(x: 10)
            }
            Text("Test is indicated at this time per current guidelines.").bold().font(.system(size: 24))
            Spacer().frame(height: 100)
            Button(action: {
                self.shouldPopToRoot = false
            }) {
                Text("Run another test")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
        }
    }
}
