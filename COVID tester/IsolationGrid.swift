//
//  IsolationGrid.swift
//  COVID tester
//
//  Created by Akhil Wadhera Old Mac on 4/1/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct non_hcw_isolation_grid_strings {
    let confirmed = [
        "Self-quarantine and actively monitor for 14 days",
        "Self-quarantine for 7 days after symptom onset and 3 days after symptom resolution, whichever is longer."
    ]
    let at_risk_travel = [
        "Self-quarantine for 14 days from date of departure",
        "Self-quarantine for 7 days after symptom onset and 3 days after symptom resolution, whichever is longer. (also, need minimum of 14 days from return)"
    ]
    let at_risk_living = [
        "Self-quarantine for 14 days from date of last contact",
        "Self-quarantine for 7 days after symptom onset and 3 days after symptom resolution (also need a minimum of 14 days from last exposure to sick person), whichever is longer."
    ]
    let at_risk_high_risk = [
        "Home isolation",
        "Self-quarantine for 3 days after symptom resolution"
    ]
    let at_risk_high_transmission = [
        "Home isolation vs social distancing depending on workplace policy",
        "Self-quarantine for 3 days after symptom resolution"
    ]
}

struct hcw_isolation_grid_strings {
    
}

struct IsolationGridQuestion: View {
    @Binding var rootIsActive: Bool
    var body: some View {
        VStack {
            Text("Is your patient a healthcare worker?").font(.title)
            Spacer()
            HStack {
                NavigationLink(destination: QuestionTwo(rootIsActive: self.$rootIsActive, result1: true)) {
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

struct QuestionTwo: View {
    @Binding var rootIsActive: Bool
    @State var result1: Bool
    var body: some View {
        VStack {
            Text("Is your patient symptomatic?").font(.title)
            Spacer()
            HStack {
                NavigationLink(destination: QuestionThree(result1: self.result1, result2: true, rootIsActive: self.$rootIsActive)) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: QuestionThree(result1: self.result1, result2: false, rootIsActive: self.$rootIsActive)) {
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

struct QuestionThree: View {
    @State var result1: Bool
    @State var result2: Bool
    @Binding var rootIsActive: Bool
    var body: some View {
        VStack {
            Text("Is your patient a laboratory-confirmed case?").font(.title)
            Spacer()
            HStack {
                NavigationLink(destination: {
                    VStack {
                        if !result1 && result2 {
                            FinishingView(advice: non_hcw_isolation_grid_strings().confirmed[0], shouldPopToRoot: self.$rootIsActive)
                        } else if !result1 && !result2 {
                            FinishingView(advice: non_hcw_isolation_grid_strings().confirmed[1], shouldPopToRoot: self.$rootIsActive)
                        } else {
                            QuestionFour(result1: self.result1, result2: self.result2, result3: true, rootIsActive: self.$rootIsActive)
                        }
                    }
                }()) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: QuestionFour(result1: false, result2: self.result2, result3: false, rootIsActive: self.$rootIsActive)) {
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

// to figure out what risk level these fools are at
struct QuestionFour: View {
    @State var result1: Bool
    @State var result2: Bool
    @State var result3: Bool
    @Binding var rootIsActive: Bool
    var body: some View {
        VStack {
            Text("Select the option that most accurately describes you.")
            NavigationLink(destination: {
                VStack {
                    if result2 {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_travel[0], shouldPopToRoot: self.$rootIsActive)
                    } else {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_travel[1], shouldPopToRoot: self.$rootIsActive)
                    }
                }
            }()) {
                Text("Travel from level 3 country")
            }
            Spacer().frame(height: 20)
            NavigationLink(destination: {
                VStack {
                    if result2 {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_living[0], shouldPopToRoot: self.$rootIsActive)
                    } else {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_living[1], shouldPopToRoot: self.$rootIsActive)
                    }
                }
            }()) {
                Text("Living in the same household as an intimate partner of, or caring for a person in a nonhealthcare setting to a person with symptomatic laboratory-confirmed COVID-19 infection for home care and home isolation")
            }
            Spacer().frame(height: 20)
            NavigationLink(destination: {
                VStack {
                    if result2 {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_high_risk[0], shouldPopToRoot: self.$rootIsActive)
                    } else {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_high_risk[1], shouldPopToRoot: self.$rootIsActive)
                    }
                }
            }()) {
                Text("Persons at high risk of COVID \n" +
                "- Age 65+ \n" +
                "Persons aged 18-65 with comorbidities")
            }
            Spacer().frame(height: 20)
            NavigationLink(destination: {
                VStack {
                    if result2 {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_high_transmission[0], shouldPopToRoot: self.$rootIsActive)
                    } else {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_high_transmission[1], shouldPopToRoot: self.$rootIsActive)
                    }
                }
            }()) {
                Text("Persons living in areas with community transmission")
            }
        }
    }
}

struct FinishingView: View {
    @State var advice: String
    @Binding var shouldPopToRoot: Bool
    var body: some View {
        VStack {
            Text(advice).font(.title)
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
