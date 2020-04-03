//
//  HCWManagementGrid.swift
//  COVID tester
//
//  Created by Akhil Wadhera Old Mac on 4/2/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

let scenarios = [
    "No symptoms",
    "If the patient has the slightest signs of illness",
    "If symptoms for <= 24 hours (no fever and URI Sx (sore throat and/or rhinorrhea and/or cough))",
    "If symptoms for >= 24 hours (fever and ILI (cough or SOB and/or myalgia and/or sore throat))"
]
let advice_scenarios = [
    "Self-monitor and continue working, notify employee health.",
    "Stay at home, home-isolate, and report to manager/chief. If symptoms resolve in <24 hours, then may return to work 72 hours after symptom resolution",
    "Stay at home, self-isolate. If symptoms improve, may return to work after symptom resolution for 72 hours.",
    "Stay at home, self-isolate, and get tested."
]

struct HCWManagementGrid: View {
    @Binding var shouldPopToRoot: Bool
    var body: some View {
        VStack {
            Group {
                Text("Exposed to a lab confirmed COVID-positive individual and ...").padding().font(.headline)
                Spacer()
                NavigationLink(destination: AdviceMenu(advice: advice_scenarios[0], shouldPopToRoot: self.$shouldPopToRoot)) {
                    Text(scenarios[0]).padding()
                }.isDetailLink(false)
                Spacer().frame(height: 20)
                NavigationLink(destination: AdviceMenu(advice: advice_scenarios[1], shouldPopToRoot: self.$shouldPopToRoot)) {
                    Text(scenarios[1]).padding()
                }.isDetailLink(false)
                Spacer().frame(height: 20)
                NavigationLink(destination: AdviceMenu(advice: advice_scenarios[2], shouldPopToRoot: self.$shouldPopToRoot)) {
                    Text(scenarios[2]).padding()
                }.isDetailLink(false)
                Spacer().frame(height: 20)
                NavigationLink(destination: AdviceMenu(advice: advice_scenarios[3], shouldPopToRoot: self.$shouldPopToRoot)) {
                    Text(scenarios[3]).padding()
                }.isDetailLink(false)
                Spacer()
            }
        }
    }
}

struct AdviceMenu: View {
    @State var advice: String
    @Binding var shouldPopToRoot: Bool
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
        }
    }
}
