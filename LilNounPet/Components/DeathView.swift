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
        
        Section("\(vm.pet.name) lived to be \(vm.pet.ageAtDeath, specifier: "%.2f") days old") {

            Button("Respawn your pet") {
                vm.toggleHatchView()
                vm.disableNotifications()
                vm.cancelNotifications()
            }
        }
        
        
    }
}

struct DeathView_Previews: PreviewProvider {
    static var previews: some View {
        DeathView()
            .environmentObject(ViewModel())
    }
}
