//
//  TestCategoryDecider.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/24/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import Foundation
import SwiftUI

struct constants {
    let tier1a = [1]
    let tier1b = [2, 3, 4, 5, 6, 7, 8]
    let tier1c = [9, 10, 11]
    let tier1d = [12]
    let tier2 = [13]
    let jobs = [
    "Patient-facing HCW or EMS or Firefighter", // T1A 0
    "Non patient-facing HCW/Medical EVS", // T1B 1
    "Police", // T1B 2
    "Resident of SNF, shelter, group home, jail", // T1B 3
    "Work in common areas of prisons/jails, as bus driver", // T1B 4
    "Frequent healthcare contact (e.g. dialysis patients, pregnant patients in third trimester)", // T1B 5
    "Bus driver/flight attendant, school/daycare teachers, postal workers", // T1B 6
    "Pregnant women over 24 weeks (not in labor, not being induced)", // T1B 7
    "Pregnant women at 36 weeks or later", // T1C 8
    "Preoperative patients.", // T1C 9
    "Dialysis patients.", // T1C 10
    "Caretaker of child less than 6 months of age", // T1D 11
    "Other"] // T2 12
    let times = ["Less than 24h", "24-48h", "48h+"]
}

struct q1: View {
    @Binding var rootIsActive: Bool
    var constants_table = constants()
    @State var question = "What does your patient do?"
    var body: some View {
        VStack {
            Text(question).font(.title).multilineTextAlignment(.center).padding(.horizontal, 5.0)
            List {
                ForEach((1...constants_table.jobs.count), id: \.self) { i in
                    NavigationLink(destination: LazyView(q2(rootIsActive: self.$rootIsActive, result1: i))){
                        Text(self.constants_table.jobs[i-1])
                    }.isDetailLink(false)
                }
            }
        }
    }
}

struct q2: View {
    @Binding var rootIsActive: Bool
    var result1: Int
    var constants_table = constants()
    @State var question = "How long have symptoms been present?"
    var body: some View {
        VStack {
            Text(question).font(.title).multilineTextAlignment(.center).padding(.horizontal, 5.0)
            List {
                NavigationLink(destination: DoNotTestView(shouldPopToRoot: $rootIsActive)) {
                  Text(constants_table.times[0])
                }.isDetailLink(false)
                NavigationLink(destination: {
                    VStack {
                        if constants_table.tier1a.contains(result1) || constants_table.tier1d.contains(result1) {
                            LazyView(q3(rootIsActive: self.$rootIsActive, result1: self.result1, result2: 2))
                        } else {
                            DoNotTestView(shouldPopToRoot: $rootIsActive)
                        }
                    }
                }()) {
                    Text(constants_table.times[1])
                }.isDetailLink(false)
                NavigationLink(destination: {
                    VStack {
                        if constants_table.tier1c.contains(result1) { // t1c
                            LazyView(q5(rootIsActive: self.$rootIsActive, result1: self.result1, result2: 3))
                        } else if constants_table.tier1a.contains(result1) { // t1a
                            LazyView(q3(rootIsActive: self.$rootIsActive, result1: self.result1, result2: 3))
                        } else if constants_table.tier1d.contains(result1) { // t1d
                            LazyView(q3(rootIsActive: self.$rootIsActive, result1: self.result1, result2: 3))
                        } else { // t1b/t2
                            LazyView(q4(rootIsActive: self.$rootIsActive, result1: self.result1, result2: 3))
                        }
                    }
                }()) {
                    Text(constants_table.times[2])
                }.isDetailLink(false)
            }
        }
    }
}

struct q3: View {
    @Binding var rootIsActive: Bool
    var result1: Int
    var result2: Int
    var constants_table = constants()
    @State var question = "Does the patient have a sore throat, runny nose, or cough?"
    var body: some View {
        // Yes/No View NavigationLinks
        VStack {
            Spacer().frame(height:50)
            Text(question).font(.title).multilineTextAlignment(.center).padding(.horizontal, 5.0)
            Spacer()
            HStack {
                NavigationLink(destination: {
                    VStack {
                        if constants_table.tier1a.contains(result1) || constants_table.tier1d.contains(result1) {
                            TestView(shouldPopToRoot: $rootIsActive)
                        } else if constants_table.tier2.contains(result1) {
                            q9(rootIsActive: self.$rootIsActive, result1: self.result1, result2: self.result2)
                        } else {
                            DoNotTestView(shouldPopToRoot: $rootIsActive)
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
                NavigationLink(destination: DoNotTestView(shouldPopToRoot: $rootIsActive)) {
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

struct q4: View {
    @Binding var rootIsActive: Bool
    var result1: Int
    var result2: Int
    var constants_table = constants()
    @State var question = "Does the patient have a fever? (Subjective/100.4 degrees)"
    var body: some View {
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center).padding(.horizontal, 5.0)
            Spacer()
            HStack {
                NavigationLink(destination: {
                    VStack {
                        if constants_table.tier2.contains(result1) {
                            q3(rootIsActive: self.$rootIsActive, result1: self.result1, result2: self.result2)
                        } else {
                            q5(rootIsActive: self.$rootIsActive, result1: self.result1, result2: self.result2)
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
                NavigationLink(destination: DoNotTestView(shouldPopToRoot: $rootIsActive)) {
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

struct q5: View {
    @Binding var rootIsActive: Bool
    var result1: Int
    var result2: Int
    var constants_table = constants()
    @State var question = "Does the patient have a cough?"
    var body: some View {
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center).padding(.horizontal, 5.0)
            Spacer()
            HStack {
                NavigationLink(destination: TestView(shouldPopToRoot: self.$rootIsActive)) {
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
                        if constants_table.tier1c.contains(result1) {
                            DoNotTestView(shouldPopToRoot: $rootIsActive)
                        } else {
                            q6(rootIsActive: self.$rootIsActive, result5: false)
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

struct q6: View {
    @Binding var rootIsActive: Bool
    var result5: Bool
    var constants_table = constants()
    @State var question = "Does the patient have shortness of breath or myalgia?"
    var body: some View {
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center).padding(.horizontal, 5.0)
            Spacer()
            HStack {
                NavigationLink(destination: TestView(shouldPopToRoot: $rootIsActive)) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: {
                    VStack {
                        if result5 {
                            TestView(shouldPopToRoot: $rootIsActive)
                        } else {
                            DoNotTestView(shouldPopToRoot: $rootIsActive)
                        }
                    }
                }()) {
                    Text("No")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25.0)
                }.isDetailLink(false)
            }
        }
    }
}

struct q7: View {
    @Binding var rootIsActive: Bool
    @State var baseAge = 64
    var body: some View {
        VStack {
            Spacer().frame(height:40)
            Text("How old is this patient?").font(.title).padding(.horizontal, 5.0)
            VStack {
                HStack {
                    Spacer()
                    Picker(selection: $baseAge, label: Text("")) {
                        ForEach(1 ..< 100) {
                            Text(String($0))
                        }
                    }.pickerStyle(WheelPickerStyle())
                }
            }
            Spacer().frame(height:40)
            NavigationLink(destination: {
                VStack {
                    if baseAge >= 65 {
                        q8(rootIsActive: self.$rootIsActive, result7: String(baseAge))
                    } else {
                        DoNotTestView(shouldPopToRoot: $rootIsActive)
                    }
                }
            }()) {
                Text("Continue")
            }.isDetailLink(false)
        }
    }
}

struct q8: View {
    @Binding var rootIsActive: Bool
    var result7: String
    var constants_table = constants()
    @State var question = "Does the patient have diabetes or asthma/COPD/chronic lung disease, or heart disease, or morbid obesity?"
    var body: some View {
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center).padding(.horizontal, 5.0)
            Spacer()
            HStack {
                NavigationLink(destination: {
                    VStack {
                        if Int(result7) ?? 65 >= 65 {
                            TestView(shouldPopToRoot: $rootIsActive)
                        } else {
                            DoNotTestView(shouldPopToRoot: $rootIsActive)
                        }
                    }
                }()) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: DoNotTestView(shouldPopToRoot: $rootIsActive)) {
                    Text("No")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25.0)
                }.isDetailLink(false)
            }
        }
    }
}

struct q9: View {
    @Binding var rootIsActive: Bool
    var result1: Int
    var result2: Int
    var constants_table = constants()
    @State var question = "Is this patient immunocompromised?"
    @State var clarifications = ["-Steroids >20mg (or > 0.5mg/kg/day in pediatrics) for > 2 weeks",
    "-On biologics or other steroid sparing immunomodulators (other than Plaquenil)",
    "-Chemotherapy for solid organ tumor or other malignancy less than 3 months ago",
    "-Hematologic malignancy not in remission",
    "-S/P autologous HSCT x 1 year, allogeneic HSCT until off immunosuppression x 1 year",
    "-Solid organ transplant recipient",
    "-Others: CVID, uncontrolled HIV, primary immunodeficiency"]

    var body: some View {
        VStack {
            Spacer()
            Text(question).font(.title).multilineTextAlignment(.center).padding(.horizontal, 5.0)
            Spacer()
            VStack(alignment: .leading) {
                ForEach(clarifications, id: \.self) { clarification in
                    Text(clarification + "\n")
                }
            }
            .padding(.horizontal, 15.0)
            Spacer()
            HStack {
                NavigationLink(destination: TestView(shouldPopToRoot: self.$rootIsActive)) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25)
                }.isDetailLink(false)
                Spacer().frame(width: 50)
                NavigationLink(destination: q7(rootIsActive: self.$rootIsActive)) {
                    Text("No")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25.0)
                }.isDetailLink(false)
            }
        }
    }
}
