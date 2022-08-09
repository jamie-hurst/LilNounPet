//
//  BuilderView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 8/8/22.
//

import SwiftUI


struct BuilderView: View {
    @EnvironmentObject var vm : ViewModel

    
    var body: some View {
        
        Form {
            ImageView()
                .environmentObject(vm)
            Text("Hi world")
        }
        
//
//        Section("Accessory") {
//            Stepper((accessories[selectedAccessory]), value: $selectedAccessory, in: 0...(accessories.count - 1))
//        }
//
//        Section("Head") {
//            Stepper((heads[selectedHead]), value: $selectedHead, in: 0...(heads.count - 1))
//            Slider(value: IntDoubleBinding($selectedHead).doubleValue, in: 0...Double(heads.count - 1), step: 1.0)
//        }
//
//        Section("Glasses") {
//            Stepper((glasses[selectedGlasses]), value: $selectedGlasses, in: 0...(glasses.count - 1))
//        }
       
    }
}
