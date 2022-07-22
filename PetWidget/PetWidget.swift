//
//  PetWidget.swift
//  PetWidget
//
//  Created by Jameson Hurst on 7/11/22.
//

import WidgetKit
import SwiftUI

struct Provider: TimelineProvider {
    
    let blankPet = Pet(name: "", bio: "", birthday: Date(), lastMeal: Date(), lastDrink: Date(), body: "", accessory: "", head: "", glasses: "")
    
    func readContents() -> Pet {
        let archiveURL =
        FileManager.sharedDocumentsDirectory.appendingPathComponent("SavedData")
        print(">>> \(archiveURL)")
        
        let decoder = JSONDecoder()
        if let codeData = try? Data(contentsOf: archiveURL) {
            do {
                let contents = try decoder.decode(Pet.self, from: codeData)
                return contents
            } catch {
                print("Error: Can't decode contents")
            }
        }
        return Pet(name: "", bio: "", birthday: Date(), lastMeal: Date(), lastDrink: Date(), body: "", accessory: "", head: "", glasses: "")
    }
    
    
    
    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), pet: blankPet)
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), pet: readContents())
        completion(entry)
    }
    
    
    
//    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
//        var entries: [SimpleEntry] = []
//        let minutesArray = [0, 15, 30, 45, 60, 75, 90, 105, 120, 135, 150, 165, 180]
//
//        // Generate a timeline consisting of five entries an hour apart, starting from the current date.
//        let currentDate = Date()
//        for minutes in minutesArray {
//            let entryDate = Calendar.current.date(byAdding: .minute, value: minutes, to: currentDate)!
//            let entry = SimpleEntry(date: entryDate, pet: readContents())
//            entries.append(entry)
//        }
//
//        let timeline = Timeline(entries: entries, policy: .atEnd)
//        completion(timeline)
//    }
    
    //    func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> ()) {
    //        var entries: [SimpleEntry] = []
    //
    //
    //        let currentDate = Date()
    //        for minutes in minutesArray {
    //            let entryDate = Calendar.current.date(byAdding: .minute, value: minutes, to: currentDate)!
    //            let entry = SimpleEntry(date: entryDate, pet: readContents())
    //            entries.append(entry)
    //        }
    //
    //        let timeline = Timeline(entries: entries, policy: .atEnd)
    //        completion(timeline)
    //    }
    
        func getTimeline(in context: Context, completion: @escaping (Timeline<Entry>) -> Void) {
                // Create a timeline entry for "now."
                let date = Date()
                let entry = SimpleEntry(
                    date: date,
                    pet: readContents()
                )
    
                // Create a date that's 15 minutes in the future.
//                let nextUpdateDate = Calendar.current.date(byAdding: .minute, value: 15, to: date)!
    
                // Create the timeline with the entry and a reload policy with the date
                // for the next update.
                let timeline = Timeline(
                    entries:[entry],
                    policy: .never
                )
    
                // Call the completion to pass the timeline to WidgetKit.
                completion(timeline)
            }
    
    
    
}


struct PetWidgetEntryView : View {
    @AppStorage("chosenBackground", store: UserDefaults(suiteName: "group.com.LilNounPet.shared")) var chosenBackground = 0
    let backgroundsArray = ["pink", "green", "cool", "warm", "black"]
    
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
                    Image(entry.pet.eyeExpression)
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
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

@main
struct PetWidget: Widget {
    let kind: String = "PetWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PetWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("My Widget")
        .description("This is an example widget.")
        .supportedFamilies([.systemSmall])
    }
}

