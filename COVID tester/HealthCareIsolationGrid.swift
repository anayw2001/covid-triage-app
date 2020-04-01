//
//  HealthCareIsolationGrid.swift
//  COVID tester
//
//  Created by Akhil Wadhera Old Mac on 3/31/20.
//  Copyright © 2020 Anay Wadhera. All rights reserved.
//

import SwiftUI

struct Grid_Row: Identifiable {
    let id = UUID()
    let cells: [Cell]
}

struct Cell: Identifiable {
    let id = UUID()
    let displayCell: String
}

extension Grid_Row {
    static func all() -> [Grid_Row] {
        return [
            Grid_Row(cells: [Cell(displayCell: isolation_grid_strings().column_titles[0]), Cell(displayCell: isolation_grid_strings().column_titles[1]), Cell(displayCell: isolation_grid_strings().column_titles[2])]),
            Grid_Row(cells: [Cell(displayCell: isolation_grid_strings().confirmed_title)]),
            Grid_Row(cells: [Cell(displayCell: isolation_grid_strings().confirmed[0]), Cell(displayCell: isolation_grid_strings().confirmed[1]), Cell(displayCell: isolation_grid_strings().confirmed[2])]),
            Grid_Row(cells: [Cell(displayCell: isolation_grid_strings().at_risk_title)]),
            Grid_Row(cells: [Cell(displayCell: isolation_grid_strings().at_risk_travel[0]), Cell(displayCell: isolation_grid_strings().at_risk_travel[1]), Cell(displayCell: isolation_grid_strings().at_risk_travel[2])]),
            Grid_Row(cells: [Cell(displayCell: isolation_grid_strings().at_risk_living[0]), Cell(displayCell: isolation_grid_strings().at_risk_living[1]), Cell(displayCell: isolation_grid_strings().at_risk_living[2])]),
            Grid_Row(cells: [Cell(displayCell: isolation_grid_strings().at_risk_high_risk[0]), Cell(displayCell: isolation_grid_strings().at_risk_high_risk[1]), Cell(displayCell: isolation_grid_strings().at_risk_high_risk[2])]),
            Grid_Row(cells: [Cell(displayCell: isolation_grid_strings().at_risk_high_transmission[0]), Cell(displayCell: isolation_grid_strings().at_risk_high_transmission[1]), Cell(displayCell: isolation_grid_strings().at_risk_high_transmission[2])])
        ]
    }
}

struct isolation_grid_strings {
    let column_titles = [
        "Risk Level",
        "Management if Asymptomatic",
        "Management if Symptomatic"
    ]
    let confirmed_title = "Confirmed COVID case"
    let confirmed = [
        "Confirmed COVID-19 case.",
        "Self-quarantine and actively monitor for 14 days",
        "Self-quarantine for 7 days after symptom onset and 3 days after symptom resolution, whichever is longer."
    ]
    let at_risk_title = "At risk of COVID exposure"
    let at_risk_travel = [
        "Travel from level 3 country",
        "Self-quarantine for 14 days from date of departure",
        "Self-quarantine for 7 days after symptom onset and 3 days after symptom resolution, whichever is longer. (also, need minimum of 14 days from return)"
    ]
    let at_risk_living = [
        "Living in the same household as an intimate partner of, or caring for a person in a nonhealthcare setting to a person with symptomatic laboratory-confirmed COVID-19 infection for home care and home isolation",
        "Self-quarantine for 14 days from date of last contact",
        "Self-quarantine for 7 days after symptom onset and 3 days after symptom resolution (also need a minimum of 14 days from last exposure to sick person), whichever is longer."
    ]
    let at_risk_high_risk = [
        "Persons at high risk of COVID \n" +
        "- Age 65+ \n" +
        "Persons aged 18-65 with comorbidities",
        "Home isolation",
        "Self-quarantine for 3 days after symptom resolution"
    ]
    let at_risk_high_transmission = [
        "Persons living in areas with community transmission",
        "Home isolation vs social distancing depending on workplace policy",
        "Self-quarantine for 3 days after symptom resolution"
    ]
}

struct IsolationGridView: View {
    let rows = Grid_Row.all()
    var body: some View {
        List {
            ForEach(rows) { row in
                HStack(alignment: .center) {
                    ForEach(row.cells) { cell in
                        Text(cell.displayCell)
                        Divider()
                    }
                }
            }
        }.padding()
    }
}

struct IsolationGridView_Preview: PreviewProvider {
    static var previews: some View {
        IsolationGridView()
    }
}
