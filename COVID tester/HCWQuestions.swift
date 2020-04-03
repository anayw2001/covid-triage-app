//
//  HCWQuestions.swift
//  COVID tester
//
//  Created by Akhil Wadhera Old Mac on 4/2/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct hcw_isolation_grid_strings {

    let advice_scenarios_symptomatic =
        "Self-quarantine and refer to HCW management grid." // display HCW management grid
    let advice_scenarios_asymptomatic =
        "Self-monitor and continue working, report to employee health."
    let advice_test_results = [
        "In all counties except Santa Clara county self-quarantine until At least 3 days (72 hours) " +
        "have passed since recovery defined as resolution of fever without the use of fever-" +
        "reducing medications and improvement in respiratory symptoms (e.g., cough, shortness " +
        "of breath); and, At least 7 days have passed since symptoms first appeared. " +
        "Santa Clara County requires 14 days after positive test OR 7 days after fever is gone and " +
        "other symptoms are improving, (whichever is longer), or other symptoms, resolve). " +
        "For ALL COUNTIES, HCWs should be restricted from contact with severely immunocompromised " +
        "patients (transplant, heme/onc) until 14 days after illness onset. " +
        "In San Joaquin county HCWs should be restricted from contact with severely " +
        "immunocompromised patients for an additional 14 days after quarantine ends (so 21 days after illness onset). " +
        "For All COUNTIES, HCWs who test positive for COVID should wear a facemask at all times " +
        "while in the healthcare facility until all symptoms including a lingering cough are " +
        "completely resolved or until 14 days after illness onset, whichever is longer. ",
        "Remain isolated until resolution of symptoms for 72 hours",
        "Return to work after resolution of symptoms for 48 hours"
    ]
}

struct QuestionTwoHCW: View {
    @Binding var rootIsActive: Bool
    @State var result1: Bool
    var body: some View {
        VStack {
            Text("Is your patient symptomatic?").font(.title)
            Spacer()
            HStack {
                NavigationLink(destination: QuestionThreeHCW(rootIsActive: self.$rootIsActive, result1: self.result1, result2: true)) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: QuestionThreeHCW(rootIsActive: self.$rootIsActive, result1: self.result1, result2: false)) {
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

struct QuestionThreeHCW: View {
    @Binding var rootIsActive: Bool
    @State var result1: Bool
    @State var result2: Bool
    var body: some View {
        VStack {
            Text("Has your patient been tested?").font(.title)
            Spacer()
            HStack {
                NavigationLink(destination: QuestionFourHCWTested(rootIsActive: self.$rootIsActive, result2: self.result2)) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: QuestionFiveHCW(rootIsActive: self.$rootIsActive, result2: self.result2)) {
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

struct QuestionFourHCWTested: View {
    @Binding var rootIsActive: Bool
    @State var result2: Bool
    var body: some View {
        VStack {
            Text("Did your patient test positive?").font(.title)
            Spacer()
            HStack {
                NavigationLink(destination: FinishingView(advice: hcw_isolation_grid_strings().advice_test_results[0], shouldPopToRoot: self.$rootIsActive, needsManagementGrid: false)) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: QuestionFiveHCW(rootIsActive: self.$rootIsActive, result2: self.result2)) {
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

struct QuestionFiveHCW: View {
    @Binding var rootIsActive: Bool
    @State var result2: Bool
    var body: some View {
        VStack {
            Text("Has your patient been exposed to a labratory confirmed case?").padding().font(.title)
            Spacer()
            HStack {
                NavigationLink(destination: {
                    VStack {
                        if result2 {
                            FinishingView(advice: hcw_isolation_grid_strings().advice_scenarios_symptomatic, shouldPopToRoot: self.$rootIsActive, needsManagementGrid: true)
                        } else {
                            FinishingView(advice: hcw_isolation_grid_strings().advice_scenarios_asymptomatic, shouldPopToRoot: self.$rootIsActive, needsManagementGrid: false)
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
                        if result2 {
                            FinishingView(advice: hcw_isolation_grid_strings().advice_scenarios_symptomatic, shouldPopToRoot: self.$rootIsActive, needsManagementGrid: false)
                        } else {
                            FinishingView(advice: hcw_isolation_grid_strings().advice_scenarios_asymptomatic, shouldPopToRoot: self.$rootIsActive, needsManagementGrid: false)
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
