//
//  BuilderView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 8/8/22.
//

import SwiftUI

struct BuilderView: View {
    @EnvironmentObject var vm : ViewModel
    
    @State private var selectedBody = 0
    @State private var selectedAccessory = 0
    @State private var selectedHead = 0
    @State private var selectedGlasses = 0
    

    var ImageBuilder: some View {
        ZStack {
            
            Group {
                Image(vm.backgroundsArray[vm.chosenBackground])
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                
                Image(bodiesArray[selectedBody])
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                
                Image(accessoriesArray[selectedAccessory])
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                
                Image(headsArray[selectedHead])
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                
                Image(glassesArray[selectedGlasses])
                    .interpolation(.none)
                    .resizable()
                    .scaledToFit()
                
            }
            
        }
    }
    
    
    var body: some View {
        VStack {
            ImageBuilder
            
            Form {
                Section("Body") {
                    Stepper((bodiesArray[selectedBody]), value: $selectedBody, in: 0...(bodiesArray.count - 1))
                    Slider(value: IntDoubleBinding($selectedBody).doubleValue, in: 0...Double(bodiesArray.count - 1), step: 1.0)
                }
                
                Section("Accessory") {
                    Stepper((accessoriesArray[selectedAccessory]), value: $selectedAccessory, in: 0...(accessoriesArray.count - 1))
                    Slider(value: IntDoubleBinding($selectedAccessory).doubleValue, in: 0...Double(accessoriesArray.count - 1), step: 1.0)
                }
                
                Section("Head") {
                    Stepper((headsArray[selectedHead]), value: $selectedHead, in: 0...(headsArray.count - 1))
                    Slider(value: IntDoubleBinding($selectedHead).doubleValue, in: 0...Double(headsArray.count - 1), step: 1.0)
                }
                
                Section("Glasses") {
                    Stepper((glassesArray[selectedGlasses]), value: $selectedGlasses, in: 0...(glassesArray.count - 1))
                    Slider(value: IntDoubleBinding($selectedGlasses).doubleValue, in: 0...Double(glassesArray.count - 1), step: 1.0)
                }
                
            }
        }
        
        
    }
}
