//
//  PetWidgetEntryView.swift
//  PetWidgetExtension
//
//  Created by Jameson Hurst on 7/22/22.
//

import WidgetKit
import SwiftUI


struct PetWidgetEntryView : View {
    @AppStorage("chosenBackground", store: UserDefaults(suiteName: "group.com.LilNounPet.shared")) var chosenBackground = 0
    let backgroundsArray = ["cool", "warm", "pink", "black"]
    
    var entry: SimpleEntry
    
    var body: some View {
        ZStack {
            Image(backgroundsArray[chosenBackground])
                .resizable()
                .scaledToFill()
            
            if !entry.pet.body.isEmpty || !entry.pet.accessory.isEmpty || !entry.pet.head.isEmpty || !entry.pet.glasses.isEmpty {
                ZStack {
                    Image(entry.pet.body)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    Image(entry.pet.accessory)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    Image(entry.pet.head)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    Image(entry.pet.glasses)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                    if !entry.pet.eyeExpression.isEmpty {
                        Image(entry.pet.eyeExpression)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                    }
                    if !entry.pet.hungerExpression.isEmpty {
                        Image(entry.pet.hungerExpression)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                    }
                    if !entry.pet.thirstExpression.isEmpty {
                        Image(entry.pet.thirstExpression)
                            .interpolation(.none)
                            .resizable()
                            .scaledToFit()
                    }
                }
            }
            
            
        }
    }
}
