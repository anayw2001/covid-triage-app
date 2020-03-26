//
//  DoNotTestView.swift
//  COVID tester
//
//  Created by Anay Wadhera on 3/25/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct DoNotTestView: View {
    var body: some View {
        VStack {
            ZStack {
                Circle().fill(Color.red).frame(width: 150, height: 150)
                Rectangle().fill(Color.white).frame(width:25, height: 110).rotationEffect(.degrees(-45))
                Rectangle().fill(Color.white).frame(width:25, height: 110).rotationEffect(.degrees(45))
            }
            Text("Do not test this patient.").bold().font(.system(size: 24))
        }
    }
}

struct DoNotTestView_Previews: PreviewProvider {
    static var previews: some View {
        DoNotTestView()
    }
}
