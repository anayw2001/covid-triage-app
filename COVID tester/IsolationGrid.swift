//
//  IsolationGrid.swift
//  COVID tester
//
//  Created by Akhil Wadhera Old Mac on 4/1/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct IsolationGridQuestion: View {
    @Binding var rootIsActive: Bool
    var body: some View {
        VStack {
            Text("Is your patient a healthcare worker?").font(.title).padding()
            Spacer()
            HStack {
                NavigationLink(destination: QuestionTwoHCW(rootIsActive: self.$rootIsActive, result1: true)) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: QuestionTwo(rootIsActive: self.$rootIsActive, result1: false)) {
                    Text("No")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }.isDetailLink(false)
            }
        }
    }
}

struct FinishingView: View {
    @State var advice: String
    @Binding var shouldPopToRoot: Bool
    @State var needsManagementGrid: Bool
    var body: some View {
        VStack {
            Text(advice).font(.headline).padding()
            Spacer().frame(height: 50)
            Button(action: {
                self.shouldPopToRoot = false
            }) {
                Text("Go back to main screen")
                    .font(.title)
                    .padding()
                    .background(Color.blue)
                    .foregroundColor(.white)
                    .cornerRadius(40)
            }
            if needsManagementGrid {
                Spacer().frame(height: 30)
                NavigationLink(destination: HCWManagementGrid(shouldPopToRoot: self.$shouldPopToRoot)) {
                    Text("Tap here to access the HCW Management Grid.")
                }.isDetailLink(false)
            }
        }
    }
}
