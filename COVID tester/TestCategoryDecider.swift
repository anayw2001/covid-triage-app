//
//  TestCategoryDecider.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/24/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import Foundation
import SwiftUI

struct results {
    var result1: Int
    var result2: Int
    var result3: Bool
    var result4: Bool
    var result5: Bool
    var result6: Bool
    var result7: Int
    var result8: Bool
    var result9: Bool
}

func q1() -> Int {
    let jobs = [
        "1": "Patient-facing healthcare worker.",
        "2": "EMS",
        "3": "Not a patient-facing healthcare worker",
        "4": "Police officer/firefighter/other first responder",
        "5": "Resident of SNF, shelter, group home, jail",
        "6": "Work in common areas of prisons/jails, as bus driver",
        "7": "Frequent healthcare contact (e.g. dialysis patients, pregnant patients in third trimester)",
        "8": "Pregnant women at 36 weeks or later",
        "9": "Preoperative patients.",
        "10": "Other"];
    return 1
}

func q2() -> Int {
    return 2
}

func q3() -> Bool {
    return false
}

func q4() -> Bool {
    return true
}

func q5() -> Bool {
    return false
}

func q6() -> Bool {
    return false
}

func q7() -> Int {
    return 65
}

func q8() -> Bool {
    return false
}

func q9() -> Bool {
    return false
}
