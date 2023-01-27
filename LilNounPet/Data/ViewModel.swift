//
//  ViewModel.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import Foundation
import SwiftUI
import UserNotifications
import ZoraAPI

enum NeedType {
    case thirst, hunger
}

@MainActor
class ViewModel: ObservableObject {
    @Published var pet: Pet
    @Published var isShowingEditView = false
    @Published var isShowingAlert = false
    @Published var mainConfetti = 0
    
    @AppStorage("tokenID") var tokenID = ""
    
    private var repository = PetRepository()
    private var imageSaver = ImageSaver()
    
    //retains user preference for notification settings
    @AppStorage("isNotificationsEnabled") var isNotificationsEnabled = false
    
    //hatchview only shows when the app first launches or when the data is reset
    @AppStorage("isShowingHatchView") var isShowingHatchView = true
    
    //saves the background user selects with UserDefaults
    @AppStorage("chosenBackground", store: UserDefaults(suiteName: "group.com.LilNounPet.shared")) var chosenBackground = 0
    let backgroundsArray = ["cool", "warm", "pink", "black"]
    
    @AppStorage("chosenTheme") var chosenTheme = 0
    let darkThemes: [Color] = [.primary, .dracPink, .dracGreen, .dracPurple, .dracCyan, .dracOrange, .dracRed, .dracYellow]
    let lightThemes: [Color] = [.primary, .pink, .green, .purple, .cyan, .orange, .red, .yellow]
    
    
    
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
        
        pet.name = ""
        pet.head = ""
        pet.body = ""
        pet.accessory = ""
        pet.glasses = ""
        
        tokenID = ""
        
        cancelNotifications()
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
    
    
    // hatching validation
    var isPetNameValid: Bool {
        if pet.name.isReallyEmpty {
            return false
        }
        return true
    }
    
    var isTokenEntryValid: Bool {
        if tokenID.isReallyEmpty {
            return true
        }
        
        if Int(tokenID) == nil {
            return false
        } else {
            return true
        }
    }
    
    func hatchPet() async {
        // If the token ID field isn't empty, try to fetch the token
        if !tokenID.isReallyEmpty {
            do {
                try await assignTokenTraits()
                
                // If the token can't be found, show the alert and bail
                if pet.isPetEmpty {
                    print("token ID entered can't be found")
                    
                    // Show the error message
                    isShowingAlert = true
                    // Bail from function
                    return
                } else {
                    print("your lil nouns has been summoned! Token found!")
                }
                
            } catch {
                print(error.localizedDescription)
            }
            
        } else {
            //user didn't attempt to enter a token ID
            randomizeTraits()
            print("no token ID entered")
        }
        
        pet.birthday = Date()
        pet.bio = ""
        pet.lastMeal = Date()
        pet.lastDrink = Date()
        
        addNotifications()
        toggleHatchView()
        mainConfetti += 1
        
        saveData()
    }
  
    func toggleHatchView() {
        isShowingHatchView.toggle()
    }
    
    
    // Zora API integration
    func fetchToken() async throws -> [NFT.Attribute]? {
        let instance = ZoraAPI.shared
        let lilNounsContractAddress = "0x4b10701Bfd7BFEdc47d50562b76b436fbB5BdB3B"
        
        return try await instance.token(address: lilNounsContractAddress, id: tokenID)?.attributes
    }
    
    // Assigns the fetched data to the current pet or returns empty strings if nothing is found
    func assignTokenTraits() async throws {
        let tokenBody = try await fetchToken()?[safe: 1]?.value ?? ""
        let tokenAccessory = try await fetchToken()?[safe: 2]?.value ?? ""
        let tokenHead = try await fetchToken()?[safe: 3]?.value ?? ""
        let tokenGlasses = try await fetchToken()?[safe: 4]?.value ?? ""
        
        if !tokenBody.isReallyEmpty || !tokenAccessory.isReallyEmpty || !tokenHead.isReallyEmpty || !tokenGlasses.isReallyEmpty {
            
            let bodyReplaced = tokenBody.replacingOccurrences(of: " ", with: "-")
            pet.body = "body-\(bodyReplaced)"
            
            let accessoryReplaced = tokenAccessory.replacingOccurrences(of: " ", with: "-")
            pet.accessory = "accessory-\(accessoryReplaced)"
            
            let headReplaced = tokenHead.replacingOccurrences(of: " ", with: "-")
            pet.head = "head-\(headReplaced)"
            
            let glassesReplaced = tokenGlasses.replacingOccurrences(of: " ", with: "-")
            pet.glasses = "glasses-\(glassesReplaced)"
        }
        
        print(pet.body)
        print(pet.accessory)
        print(pet.head)
        print(pet.glasses)
    }
    
    //saves the image in standard 500x500 pixel sizing in PNG format
    func savePetImageToPhotoAlbum() {
        if !pet.isPetEmpty {
            let compositePetImage: UIImage = UIImage(named: backgroundsArray[chosenBackground])!
                .createCompositeImage(layer2: UIImage(named: pet.body)!,
                                      layer3: UIImage(named: pet.accessory)!,
                                      layer4: UIImage(named: pet.head)!,
                                      layer5: UIImage(named: pet.glasses)!)
            
            imageSaver.writeToPhotoAlbum(image: compositePetImage.resize(targetSize: CGSize(width: 166.6, height: 166.6)))
        } else {
            print("Error saving the composite image or writing to the Photo album.")
        }
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
    
    func cancelNotifications() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        UNUserNotificationCenter.current().removeAllDeliveredNotifications()
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
                content.title = "\(self.pet.name) is Thirsty"
                content.subtitle = "Give it water or it will die in 2 hours."
                hoursUntilWarning = 10
            }
            
            if needType == .hunger {
                content.title = "\(self.pet.name) is Hungry"
                content.subtitle = "Give it food or it will die in 2 hours."
                hoursUntilWarning = 22
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
