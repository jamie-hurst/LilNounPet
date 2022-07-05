//
//  DeathView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI

struct DeathView: View {
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        Section("Your pet has died. ☠️") {
            Text("Here lies \(vm.pet.name), born \(vm.pet.birthday.formatted())")
            Text("They lived to be \(vm.pet.ageAtDeath, specifier: "%.2f") days old.")
    
            Text("last meal: \(vm.pet.lastMeal.formatted())")
            Text("last drink: \(vm.pet.lastDrink.formatted())")
        }
        
        Button("Respawn your pet") {
            vm.toggleHatchView()
            vm.disableNotifications()
            vm.cancelNotifications()
        }
    }
}

struct DeathView_Previews: PreviewProvider {
    static var previews: some View {
        DeathView()
            .environmentObject(ViewModel())
    }
}
