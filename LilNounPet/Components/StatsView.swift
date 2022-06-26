//
//  StatsView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI

struct StatsView: View {
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
                
                Text(vm.pet.thirst)
                    .foregroundColor(vm.darkThemes[vm.chosenTheme])
            }
            
            HStack {
                Text("Hunger")
                Spacer()
                
                Text(vm.pet.hunger)
                    .foregroundColor(vm.darkThemes[vm.chosenTheme])
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
