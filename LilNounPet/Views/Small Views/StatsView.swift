//
//  StatsView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI

let healthLevels = [
    1: "♥︎♡♡♡♡♡",
    2: "♥︎♥︎♡♡♡♡",
    3: "♥︎♥︎♥︎♡♡♡",
    4: "♥︎♥︎♥︎♥︎♡♡",
    5: "♥︎♥︎♥︎♥︎♥︎♡",
    6: "♥︎♥︎♥︎♥︎♥︎♥︎",
]

struct StatsView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        Section {
            HStack {
                Text("Age")
                Spacer()
                
                Text("\(vm.pet.age, specifier: "%.2f") days")
            }
            
            HStack {
                Text("Thirst")
                Spacer()
                
                Text(healthLevels[vm.pet.thirst]!)
                    .foregroundColor(colorScheme == .dark ? .dracPink : .red)
            }
            
            HStack {
                Text("Hunger")
                Spacer()
                
                Text(healthLevels[vm.pet.hunger]!)
                    .foregroundColor(colorScheme == .dark ? .dracPink : .red)
            }
        }

    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(ViewModel())
    }
}
