//
//  ViewModel.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import Foundation
import SwiftUI
import UserNotifications

enum NeedType {
    case thirst, hunger
}

@MainActor class ViewModel: ObservableObject {
    @Published var pet: Pet
    private var repository = PetRepository()
    
    @Published var isShowingEditView = false
    
    //retains user preference for notification settings
    @AppStorage("isNotificationsEnabled") var isNotificationsEnabled = false
    
    //hatchview only shows when the app first launches or when the data is reset
    @AppStorage("isShowingHatchView") var isShowingHatchView = true
    
    //saves the background user selects with UserDefaults
    @AppStorage("chosenBackground") var chosenBackground = 0
    let backgroundsArray = ["black", "cool", "warm", "pink", "green"]
    
    @AppStorage("chosenTheme") var chosenTheme = 0
    let darkThemes: [Color] = [.dracPink, .dracGreen, .dracPurple, .dracWhite, .dracCyan, .dracOrange, .dracRed, .dracYellow]
    let lightThemes: [Color] = [.pink, .green, .purple, .primary, .cyan, .orange, .red, .yellow]
    
    
    
    //data management
    init() {
        pet = repository.loadData()
    }
    
    func saveData() {
        objectWillChange.send()
        repository.saveData(pet: pet)
    }
    
    func resetData() {
        isShowingHatchView = true
        pet = Pet(name: "", bio: "", lastMeal: Date(), lastDrink: Date(), body: randomBody(), accessory: randomAccessory(), head: randomHead(), glasses: randomGlasses())
        isNotificationsEnabled = false
        saveData()
    }
    
    //pet commands
    func feed() {
        pet.lastMeal = Date()
        addNotificationIfEnabled(for: .hunger)
        saveData()
    }
    
    func giveWater() {
        pet.lastDrink = Date()
        addNotificationIfEnabled(for: .thirst)
        saveData()
    }
    
    
    //functions to assign random properties when the pet data is reset
    func randomBody() -> String {
        let randomBody = Int.random(in: 0..<bodiesArray.count)
        return bodiesArray[randomBody]
    }
    
    func randomAccessory() -> String {
        let randomAccessory = Int.random(in: 0..<accessoriesArray.count)
        return accessoriesArray[randomAccessory]
    }
    
    func randomHead() -> String {
        let randomHat = Int.random(in: 0..<headsArray.count)
        return headsArray[randomHat]
    }
    
    func randomGlasses() -> String {
        let randomGlasses = Int.random(in: 0..<glassesArray.count)
        return glassesArray[randomGlasses]
    }
    
    func randomizeTraits() {
        
        pet.body = randomBody()
        pet.accessory = randomAccessory()
        pet.head = randomHead()
        pet.glasses = randomGlasses()
    }
    
    
    //hatching
    func hatchPet() {
        pet.birthday = Date()
        pet.bio = ""
        pet.lastMeal = Date()
        pet.lastDrink = Date()
        
        randomizeTraits()
        addNotifications()
        toggleHatchView()
        
        saveData()
    }
    
    func toggleHatchView() {
        isShowingHatchView.toggle()
    }
    
    
    //haptic feedback
    func hapticSuccess() {
        let generator = UINotificationFeedbackGenerator()
        generator.notificationOccurred(.success)
    }
    
    
    
    
    
    //Notification helper functions
    func requestNotificationAuthorization() {
        let center = UNUserNotificationCenter.current()
        center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
            if success {
                print("success, notifications are now authorized.")
            } else {
                print("Notifications not authorized.")
            }
        }
    }
    
    
    func disableNotifications() {
        isNotificationsEnabled = false
    }
    
    func addNotificationIfEnabled(for needType: NeedType) {
        guard isNotificationsEnabled else { return }
        
        if needType == .thirst {
            addNotification(for: .thirst)
        }
        
        if needType == .hunger {
            addNotification(for: .hunger)
        }
    }
    
    func addNotifications() {
        addNotificationIfEnabled(for: .thirst)
        addNotificationIfEnabled(for: .hunger)
    }

    
    //adds local notification for impending pet death
    private func addNotification(for needType: NeedType) {
        let center = UNUserNotificationCenter.current()
        
        let addRequest = {
            let content = UNMutableNotificationContent()
            content.sound = UNNotificationSound.default
            var hoursUntilWarning = 0
            
            if needType == .thirst {
            content.title = "Your Pet is Thirsty"
            content.subtitle = "Give it water or it will die."
            hoursUntilWarning = 10
            }
            
            if needType == .hunger {
            content.title = "Your Pet is Hungry"
            content.subtitle = "Give it food or it will die."
            hoursUntilWarning = 20
            }
            
            let nextTriggerDate = Calendar.current.date(byAdding: .hour, value: hoursUntilWarning, to: Date()) ?? Date.now
            let comps = Calendar.current.dateComponents([.day, .hour, .minute, .second], from: nextTriggerDate)

            let trigger = UNCalendarNotificationTrigger(dateMatching: comps, repeats: false)
 
            let request = UNNotificationRequest(identifier: (needType == .thirst ? "thirst" : "hunger"), content: content, trigger: trigger)
            center.add(request)
        }
        
        center.getNotificationSettings { settings in
            
            if settings.authorizationStatus == .authorized {
                addRequest()
                print("success. your notification has been added champ.")
            } else {
                center.requestAuthorization(options: [.alert, .badge, .sound]) { success, error in
                    if success {
                        addRequest()
                        print("success. your notification has been added.")
                    } else {
                        print("D'oh")
                    }
                }
            }
        }
        
        
    }
    
    
}
