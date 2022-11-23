//
//  BuilderView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 8/8/22.
//

import SwiftUI
import SDWebImageSwiftUI

struct BuilderView: View {
    @EnvironmentObject var vm : ViewModel
    
    @State private var selectedBody = 0
    @State private var selectedAccessory = 0
    @State private var selectedHead = 0
    @State private var selectedGlasses = 0
    
    
    var AccessoryEditor: some View {
        Section("Accessory") {
            //Drops the word "accessory-" from the filename unless the "body-" naming convention is used (only 4 use body in the name)
            let displayedAccessory = accessoriesArray[selectedAccessory].contains("accessory") ? String(accessoriesArray[selectedAccessory].dropFirst(10)) : String(accessoriesArray[selectedAccessory].dropFirst(5))
            
            Stepper(displayedAccessory, value: $selectedAccessory, in: 0...(accessoriesArray.count - 1))
            Slider(value: IntDoubleBinding($selectedAccessory).doubleValue, in: 0...Double(accessoriesArray.count - 1), step: 1.0)
        }
    }
    
    var BodyEditor: some View {
        Section("body") {
            //Drops the first 5 characters from the filename to remove "body-"
            let displayedBody = String(bodiesArray[selectedBody].dropFirst(5))
            
            Stepper(displayedBody, value: $selectedBody, in: 0...(bodiesArray.count - 1))
            Slider(value: IntDoubleBinding($selectedBody).doubleValue, in: 0...Double(bodiesArray.count - 1), step: 1.0)
        }
    }
    
    var GlassesEditor: some View {
        Section("noggles") {
            //Drops the first 8 characters from the filename to remove "glasses-"
            let displayedGlasses = String(glassesArray[selectedGlasses].dropFirst(8))
            
            Stepper(displayedGlasses, value: $selectedGlasses, in: 0...(glassesArray.count - 1))
            Slider(value: IntDoubleBinding($selectedGlasses).doubleValue, in: 0...Double(glassesArray.count - 1), step: 1.0)
        }
    }
    
    
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
        
        if vm.pet.isThreeDaysOldOrOlder {
            
            Form {
                ImageBuilder
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                BodyEditor
                AccessoryEditor
                GlassesEditor
                
                Section {
                    Text("🎉 You've unlocked editing for all traits!")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                }
            }
            .onAppear {
                let bodyIndex = bodiesArray.firstIndex(of: vm.pet.body)!
                let accessoryIndex = accessoriesArray.firstIndex(of: vm.pet.accessory)!
                let headIndex = headsArray.firstIndex(of: vm.pet.head)!
                let glassesIndex = glassesArray.firstIndex(of: vm.pet.glasses)!
                
                selectedBody = bodyIndex
                selectedAccessory = accessoryIndex
                selectedHead = headIndex
                selectedGlasses = glassesIndex
            }
            .onDisappear {
                vm.pet.body = bodiesArray[selectedBody]
                vm.pet.accessory = accessoriesArray[selectedAccessory]
                vm.pet.head = headsArray[selectedHead]
                vm.pet.glasses = glassesArray[selectedGlasses]
                
                vm.saveData()
            }
            
            
        } else if vm.pet.isTwoDaysOldOrOlder {
            
            Form {
                ImageBuilder
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                BodyEditor
                AccessoryEditor
                
                Section {
                    Text("🎉 Editing unlocked for 2 of 3 traits")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                    
                }
            }
            .onAppear {
                let bodyIndex = bodiesArray.firstIndex(of: vm.pet.body)!
                let accessoryIndex = accessoriesArray.firstIndex(of: vm.pet.accessory)!
                let headIndex = headsArray.firstIndex(of: vm.pet.head)!
                let glassesIndex = glassesArray.firstIndex(of: vm.pet.glasses)!
                
                selectedBody = bodyIndex
                selectedAccessory = accessoryIndex
                selectedHead = headIndex
                selectedGlasses = glassesIndex
            }
            .onDisappear {
                vm.pet.body = bodiesArray[selectedBody]
                vm.pet.accessory = accessoriesArray[selectedAccessory]
                vm.pet.head = headsArray[selectedHead]
                vm.pet.glasses = glassesArray[selectedGlasses]
                
                vm.saveData()
            }
            
        } else if vm.pet.isOneDayOldOrOlder {
            
            Form {
                ImageBuilder
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                AccessoryEditor
                
                Section {
                    Text("🎉 Editing unlocked for 1 of 3 traits")
                        .frame(maxWidth: .infinity, alignment: .center)
                        .padding(.vertical, 8)
                }
            }
            .onAppear {
                let bodyIndex = bodiesArray.firstIndex(of: vm.pet.body)!
                let accessoryIndex = accessoriesArray.firstIndex(of: vm.pet.accessory)!
                let headIndex = headsArray.firstIndex(of: vm.pet.head)!
                let glassesIndex = glassesArray.firstIndex(of: vm.pet.glasses)!
                
                selectedBody = bodyIndex
                selectedAccessory = accessoryIndex
                selectedHead = headIndex
                selectedGlasses = glassesIndex
            }
            .onDisappear {
                vm.pet.body = bodiesArray[selectedBody]
                vm.pet.accessory = accessoriesArray[selectedAccessory]
                vm.pet.head = headsArray[selectedHead]
                vm.pet.glasses = glassesArray[selectedGlasses]
                
                vm.saveData()
            }
            
        } else {
            
            VStack {
                Image(systemName: "hourglass.circle")
                    .font(.system(size: 60))
                
                Text("Come back when your pet is a day old to customize your traits.")
                    .multilineTextAlignment(.center)
                    .font(Font.custom("LondrinaSolid-Regular", size: 24, relativeTo: .title))
                    .padding()
                
            }
            .padding()
            
        }
        
        
    }
}
