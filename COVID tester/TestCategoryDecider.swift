//
//  TestCategoryDecider.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/24/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import Foundation
import SwiftUI

struct YesNoQuestionView: View {
    var question: String
    var body: some View {
        VStack {
            Text(question)
            Spacer()
            YesNoView()
        }
    }
}

struct ChoiceRow: View {
    var toDisplay: String
    var body: some View {
        HStack {
            Text(toDisplay)
        }
    }
}

struct OptionsQuestionView: View {
    var question: String
    var choices: [String]
    var body: some View {
        VStack {
            Text(question)
            List(choices, id: \.self) { choice in
                ChoiceRow(toDisplay: choice)
            }
        }
    }
}

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
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                }
                .buttonStyle(DefaultButtonStyle())
                Spacer()
                Button(action: {
                    print("No")
                }) {
                    Text("No")
                        .font(.title)
                        .multilineTextAlignment(.center)
                        .padding()
                        .background(Color.blue
                            .buttonStyle(/*@START_MENU_TOKEN@*/ /*@PLACEHOLDER=Button Style@*/DefaultButtonStyle()/*@END_MENU_TOKEN@*/))
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(/*@START_MENU_TOKEN@*/10.0/*@END_MENU_TOKEN@*/)
                }
            }
            Spacer()
        }
    }
}

struct constants {
    var result1: Int
    var result2: Int
    var result3: Bool
    var result4: Bool
    var result5: Bool
    var result6: Bool
    var result7: Int
    var result8: Bool
    var result9: Bool
    let jobs = [
    "Patient-facing healthcare worker.",
    "EMS",
    "Not a patient-facing healthcare worker",
    "Police officer/firefighter/other first responder",
    "Resident of SNF, shelter, group home, jail",
    "Work in common areas of prisons/jails, as bus driver",
    "Frequent healthcare contact (e.g. dialysis patients, pregnant patients in third trimester)",
    "Pregnant women at 36 weeks or later",
    "Preoperative patients.",
    "Other"];
    let times = ["Less than 24h", "24-48h", "48h+"];
    
}

func askQuestions() {
    var results_table = constants(result1: 0, result2: 0, result3: false, result4: false, result5: false, result6: false, result7: 0, result8: false, result9: false)
    results_table.result1 = 3;
    
}

struct q1: View {
    var results_table: constants
    var body: some View {
        OptionsQuestionView(question: "What does your patient do?", choices: results_table.jobs)
    }
}

struct q2: View {
    var results_table: constants
    var body: some View {
        OptionsQuestionView(question: "How long have the symptoms been present?", choices: results_table.times)
    }
}

struct q3: View {
    var body: some View {
        YesNoQuestionView(question: "Does the patient have a sore throat, runny nose, or cough?")
    }
}

struct q4: View {
    var body: some View {
        YesNoQuestionView(question: "Does the patient have a fever? (Subjective/100.4 degrees)")
    }
}

struct q5: View {
    var body: some View {
        YesNoQuestionView(question: "Does the patient have a cough?")
    }
}

struct q6: View {
    var body: some View {
        YesNoQuestionView(question: "Does the patient have a shortness of breath or myalgia?")
    }
}

func q7() -> Int {
    return 65
}

struct q8: View {
    var body: some View {
        YesNoQuestionView(question: "Does the patient have a shortness of breath or myalgia?")
    }
}

struct q9: View {
    var body: some View {
        YesNoQuestionView(question: "Does the patient have a shortness of breath or myalgia?")
    }
}
