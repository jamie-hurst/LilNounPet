//
//  Pet-Repository.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI


class PetRepository {
    private var pet: Pet
    
    //shortcut to the documents directory save path
    let savePath = FileManager.documentsDirectory.appendingPathComponent("SavedData")
    
    //loading in data from the documents directory
    init() {
        if let data = try? Data(contentsOf: savePath) {
            if let decoded = try? JSONDecoder().decode(Pet.self, from: data) {
                pet = decoded
                return
            }
        }

        pet = Pet(name: "", bio: "", lastMeal: Date(), lastDrink: Date(), body: "", accessory: "", head: "", glasses: "")
    }
    
    func loadData() -> Pet {
        return self.pet
    }
    
    func saveData(pet: Pet) {
        if let encoded = try? JSONEncoder().encode(pet) {
            try? encoded.write(to: savePath, options: [.atomic, .completeFileProtection])
            print("Data saved at: \(Date().formatted(date: .omitted, time: .standard))")
        }
    }
}
