//
//  TestView.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/25/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct TestView: View {
    var body: some View {
        VStack {
            ZStack {
                Circle().fill(Color.green).frame(width: 150, height: 150)
                Rectangle().fill(Color.white).frame(width:25, height: 40).rotationEffect(.degrees(-45)).offset(x: -40, y: 10)
                Rectangle().fill(Color.white).frame(width:25, height: 110).rotationEffect(.degrees(45)).offset(x: 10)
            }
            Text("Test this patient.").bold().font(.system(size: 24))
        }
    }
}

struct TestView_Previews: PreviewProvider {
    static var previews: some View {
        TestView()
    }
}
