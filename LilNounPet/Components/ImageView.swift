//
//  ImageView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI

struct ImageView: View {
    @EnvironmentObject var vm : ViewModel
    
    var body: some View {
        ZStack {
            Image(vm.backgroundsArray[vm.chosenBackground])
                .resizable()
                .scaledToFill()
            ZStack {
                //only display the frog if it has been hatched; these string values are empty until the hatchview done "button" is pressed
                if !vm.pet.body.isEmpty || !vm.pet.accessory.isEmpty || !vm.pet.head.isEmpty || !vm.pet.glasses.isEmpty {
                    
                    Image(vm.pet.body)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    Image(vm.pet.accessory)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    Image(vm.pet.head)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    Image(vm.pet.glasses)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                }
            }
            .frame(width: 280, height: 280)
            
            
        }
        .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
        
    }
}

struct ImageView_Previews: PreviewProvider {
    static var previews: some View {
        ImageView()
            .environmentObject(ViewModel())
    }
}
