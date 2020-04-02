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
    let scenarios = [
        "No symptoms",
        "If the patient has the slightest signs of illness",
        "If symptoms for <= 24 hours (no fever and URI Sx (sore throat and/or rhinorrhea and/or cough))",
        "If symptoms for >= 24 hours (fever and ILI (cough or SOB and/or myalgia and/or sore throat))"
    ]
    let advice_scenarios = [
        "Self-monitor and continue working, notify employee health.",
        "Stay at home, and report to manager/chief. If symptoms resolve in <24 hours, then may return to work 72 hours after symptom resolution",
        "Stay at home, self-isolate. If symptoms improve, may return to work after symptom resolution for 72 hours.",
        "Stay at home, self-isolate, and get tested."
    ]
    let advice_test_results = [
        "Self isolate at home for 7 days from onset of symptoms or 72 hours after resolution of symptoms, whichever is longer",
        "Remain isolated until resolution of symptoms for 72 hours",
        "Return to work after resolution of symptoms for 48 hours"
    ]
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
            if result1 {
                Text("Has your patient gotten tested?").font(.title)
            } else {
                Text("Is your patient a laboratory-confirmed case?").font(.title)
            }
            Spacer()
            HStack {
                NavigationLink(destination: {
                    VStack {
                        if !result1 && result2 { // not hcw and symptomatic
                            FinishingView(advice: non_hcw_isolation_grid_strings().confirmed[1], shouldPopToRoot: self.$rootIsActive)
                        } else if !result1 && !result2 { // not hcw and asymptomatic
                            FinishingView(advice: non_hcw_isolation_grid_strings().confirmed[0], shouldPopToRoot: self.$rootIsActive)
                        } else { // hcw tested
                            QuestionFourHCWTested(rootIsActive: self.$rootIsActive)
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
                NavigationLink(destination: {
                    VStack {
                        if result1 { // hcw untested
                            QuestionFourHCWUntested(result1: self.result1, result2: self.result2, result3: false, rootIsActive: self.$rootIsActive)
                        } else { // non-hcw untested
                            QuestionFour(result1: self.result1, result2: self.result2, result3: false, rootIsActive: self.$rootIsActive)
                        }
                    }
                }()) {
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
            Text("Select the option that most accurately describes the patient.").font(.title)
            NavigationLink(destination: {
                VStack {
                    if result2 {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_travel[1], shouldPopToRoot: self.$rootIsActive)
                    } else {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_travel[0], shouldPopToRoot: self.$rootIsActive)
                    }
                }
            }()) {
                Text("Travel from level 3 country").padding()
            }
            Spacer().frame(height: 20)
            NavigationLink(destination: {
                VStack {
                    if result2 {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_living[1], shouldPopToRoot: self.$rootIsActive)
                    } else {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_living[0], shouldPopToRoot: self.$rootIsActive)
                    }
                }
            }()) {
                Text("Living in the same household as an intimate partner of, or caring for a person in a nonhealthcare setting to a person with symptomatic laboratory-confirmed COVID-19 infection for home care and home isolation").padding()
            }
            Spacer().frame(height: 20)
            NavigationLink(destination: {
                VStack {
                    if result2 {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_high_risk[1], shouldPopToRoot: self.$rootIsActive)
                    } else {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_high_risk[0], shouldPopToRoot: self.$rootIsActive)
                    }
                }
            }()) {
                Text("Persons at high risk of COVID \n" +
                "- Age 65+ \n" +
                "Persons aged 18-65 with comorbidities").padding()
            }
            Spacer().frame(height: 20)
            NavigationLink(destination: {
                VStack {
                    if result2 {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_high_transmission[1], shouldPopToRoot: self.$rootIsActive)
                    } else {
                        FinishingView(advice: non_hcw_isolation_grid_strings().at_risk_high_transmission[0], shouldPopToRoot: self.$rootIsActive)
                    }
                }
            }()) {
                Text("Persons living in areas with community transmission").padding()
            }
        }
    }
}

struct QuestionFourHCWTested: View {
    @Binding var rootIsActive: Bool
    var body: some View {
        VStack {
            Text("Did your patient test positive?").font(.title)
            Spacer()
            HStack {
                NavigationLink(destination: FinishingView(advice: hcw_isolation_grid_strings().advice_test_results[0], shouldPopToRoot: self.$rootIsActive)) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: FinishingView(advice: hcw_isolation_grid_strings().advice_test_results[2], shouldPopToRoot: self.$rootIsActive)) {
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
struct QuestionFourHCWUntested: View {
    @State var result1: Bool
    @State var result2: Bool
    @State var result3: Bool
    @Binding var rootIsActive: Bool
    var body: some View {
        VStack {
            Text("Select the option that most accurately describes the patient.")
            Spacer().frame(height: 30)
            Text("Exposed to a laboratory confirmed COVID positive individal and...").font(.subheadline).padding()
            Group {
                NavigationLink(destination: FinishingView(advice: hcw_isolation_grid_strings().advice_scenarios[0], shouldPopToRoot: self.$rootIsActive)) {
                    Text(hcw_isolation_grid_strings().scenarios[0]).padding()
                }
                Spacer().frame(height: 20)
                NavigationLink(destination: FinishingView(advice: hcw_isolation_grid_strings().advice_scenarios[1], shouldPopToRoot: self.$rootIsActive)) {
                    Text(hcw_isolation_grid_strings().scenarios[1]).padding()
                }
                Spacer().frame(height: 20)
                NavigationLink(destination: FinishingView(advice: hcw_isolation_grid_strings().advice_scenarios[2], shouldPopToRoot: self.$rootIsActive)) {
                    Text(hcw_isolation_grid_strings().scenarios[2]).padding()
                }
                Spacer().frame(height: 20)
                NavigationLink(destination: FinishingView(advice: hcw_isolation_grid_strings().advice_scenarios[3], shouldPopToRoot: self.$rootIsActive)) {
                    Text(hcw_isolation_grid_strings().scenarios[3]).padding()
                }
                Spacer().frame(height: 20)
                NavigationLink(destination: FinishingView(advice:hcw_isolation_grid_strings().advice_test_results[1], shouldPopToRoot: self.$rootIsActive)) {
                    Text("None of the above.").padding()
                }
            }
        }
    }
}

struct FinishingView: View {
    @State var advice: String
    @Binding var shouldPopToRoot: Bool
    var body: some View {
        VStack {
            Text(advice).font(.title).padding()
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
