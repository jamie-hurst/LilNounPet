//
//  StatsView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI

struct StatsView: View {
    @Environment(\.colorScheme) var colorScheme
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        Section("Stats") {
            HStack {
                Text("Age")
                Spacer()
                
                Text("\(vm.pet.age, specifier: "%.2f") days")
            }
            
            HStack {
                Text("Thirst")
                Spacer()
                
                Text(healthLevels[vm.pet.thirst]!)
                    .foregroundColor(colorScheme == .dark ? vm.darkThemes[vm.chosenTheme] : vm.lightThemes[vm.chosenTheme])
            }
            
            HStack {
                Text("Hunger")
                Spacer()
                
                Text(healthLevels[vm.pet.hunger]!)
                    .foregroundColor(colorScheme == .dark ? vm.darkThemes[vm.chosenTheme] : vm.lightThemes[vm.chosenTheme])
            }
        }
        
//        Section {
//            Text("birthday: \(vm.pet.birthday.formatted())")
//            Text("last meal: \(vm.pet.lastMeal.formatted())")
//            Text("last drink: \(vm.pet.lastDrink.formatted())")
//        }
        
    }
}

struct StatsView_Previews: PreviewProvider {
    static var previews: some View {
        StatsView()
            .environmentObject(ViewModel())
    }
}
