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
    let jobs = [
    "Patient-facing HCW or EMS", // T1A
    "Non patient-facing HCW", // T1B
    "First responder (police, fire, etc.)", // T1B
    "Resident of SNF, shelter, group home, jail", // T1B
    "Work in common areas of prisons/jails, as bus driver", // T1B
    "Frequent healthcare contact (e.g. dialysis patients, pregnant patients in third trimester)", // T1B
    "Bus driver/flight attendant", // T1B
    "Pregnant women at 36 weeks or later", // T1C
    "Preoperative patients.", // T1C
    "Caretaker of child less than 6 months of age", // T1D
    "Other"] // T2
    let times = ["Less than 24h", "24-48h", "48h+"]
}

struct q1: View {
    var results_table = constants()
    @State var question = "What does your patient do?"
    var body: some View {
        VStack {
            Text(question).font(.title).multilineTextAlignment(.center)
            List {
                ForEach((1...results_table.jobs.count), id: \.self) { i in
                    NavigationLink(destination: q2(result1: i)){
                        Text(self.results_table.jobs[i-1])
                    }
                }
            }
        }
    }
}

struct q2: View {
    var result1: Int
    var results_table = constants()
    @State var question = "How long have symptoms been present?"
    var body: some View {
        VStack {
            Text(question).font(.title).multilineTextAlignment(.center)
            List {
                NavigationLink(destination: DoNotTestView()) {
                  Text(results_table.times[0])
                }
                NavigationLink(destination: {
                    VStack {
                        if result1 == 1 || result1 == 10 {
                            q3(result1: self.result1, result2: 2)
                        } else {
                            DoNotTestView()
                        }
                    }
                }()) {
                    Text(results_table.times[1])
                }
                NavigationLink(destination: {
                    VStack {
                        if result1 == 8 || result1 == 9 {
                            q5(result1: self.result1, result2: 3)
                        } else if result1 == 1 {
                            q3(result1: self.result1, result2: 3)
                        } else if result1 == 11 || result1 == 10 {
                            q3(result1: self.result1, result2: 3)
                        } else {
                            q4(result1: self.result1, result2: 3)
                        }
                    }
                }()) {
                    Text(results_table.times[2])
                }
            }
        }
    }
}

struct q3: View {
    var result1: Int
    var result2: Int
    @State var question = "Does the patient have a sore throat, runny nose, or cough?"
    var body: some View {
        // Yes/No View NavigationLinks
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center)
            Spacer().frame(height:250)
            HStack {
                NavigationLink(destination: {
                    VStack {
                        if result1 == 1 || result1 == 10 {
                            TestView()
                        } else if result1 == 11 {
                            q9(result1: self.result1, result2: self.result2)
                        } else {
                            DoNotTestView()
                        }
                    }
                }()) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }
                Spacer().frame(width: 50)
                NavigationLink(destination: DoNotTestView()) {
                    Text("No")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }
            }
        }
    }
}

struct q4: View {
    var result1: Int
    var result2: Int
    var results_table = constants()
    @State var question = "Does the patient have a fever? (Subjective/100.4 degrees)"
    var body: some View {
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center)
            Spacer().frame(height:250)
            HStack {
                NavigationLink(destination: q5(result1: self.result1, result2: self.result2)) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }
                Spacer().frame(width: 50)
                NavigationLink(destination: DoNotTestView()) {
                    Text("No")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }
            }
        }
    }
}

struct q5: View {
    var result1: Int
    var result2: Int
    var results_table = constants()
    @State var question = "Does the patient have a cough?"
    var body: some View {
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center)
            Spacer().frame(height:250)
            HStack {
                NavigationLink(destination: TestView()) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }
                Spacer().frame(width: 50)
                NavigationLink(destination: {
                    VStack {
                        if result1 == 8 || result1 == 9 {
                            DoNotTestView()
                        } else {
                            q6(result5: false)
                        }
                    }
                }()) {
                    Text("No")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                }
            }
        }
    }
}

struct q6: View {
    var result5: Bool
    var results_table = constants()
    @State var question = "Does the patient have shortness of breath or myalgia?"
    var body: some View {
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center)
            Spacer().frame(height:250)
            HStack {
                NavigationLink(destination: TestView()) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25)
                }
                Spacer().frame(width: 50)
                NavigationLink(destination: {
                    VStack {
                        if result5 {
                            TestView()
                        } else {
                            DoNotTestView()
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
                }
            }
        }
    }
}

struct q7: View {
    @State var baseAge = "65"
    var body: some View {
        VStack {
            Spacer().frame(height:40)
            Text("How old is this patient?").font(.title)
            HStack {
                TextField("", text: $baseAge)
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(10.0)
                    .fixedSize(horizontal: true, vertical: true).frame(width: 100, height: 40)
            }
            Spacer().frame(height:40)
            NavigationLink(destination: {
                VStack {
                    if Int(baseAge) ?? 65 >= 65 {
                        q8(result7: baseAge)
                    } else {
                        DoNotTestView()
                    }
                }
            }()) {
                Text("Continue")
            }
        }
    }
}

struct q8: View {
    var result7: String
    var results_table = constants()
    @State var question = "Does the patient have diabetes or asthma/COPD/chronic lung disease, or heart disease, or morbid obesity?"
    var body: some View {
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center)
            Spacer().frame(height:250)
            HStack {
                NavigationLink(destination: {
                    VStack {
                        if Int(result7) ?? 65 >= 65 {
                            TestView()
                        } else {
                            DoNotTestView()
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
                }
                Spacer().frame(width: 50)
                NavigationLink(destination: DoNotTestView()) {
                    Text("No")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25.0)
                }
            }
        }
    }
}

struct q9: View {
    var result1: Int
    var result2: Int
    var results_table = constants()
    @State var question = "Is this patient immunocompromised?"
    var body: some View {
        VStack {
            Spacer().frame(height:150)
            Text(question).font(.title).multilineTextAlignment(.center)
            Spacer().frame(height:250)
            HStack {
                NavigationLink(destination: TestView()) {
                    Text("Yes")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25)
                }
                Spacer().frame(width: 50)
                NavigationLink(destination: q7()) {
                    Text("No")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .padding(10)
                        .cornerRadius(25.0)
                }
            }
        }
    }
}
