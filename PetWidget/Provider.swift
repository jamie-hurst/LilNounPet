//
//  Provider.swift
//  PetWidgetExtension
//
//  Created by Jameson Hurst on 7/21/22.
//

import WidgetKit

struct Provider: TimelineProvider {
    

    func placeholder(in context: Context) -> SimpleEntry {
        SimpleEntry(date: Date(), pet: readContents())
    }
    
    func getSnapshot(in context: Context, completion: @escaping (SimpleEntry) -> ()) {
        let entry = SimpleEntry(date: Date(), pet: readContents())
        completion(entry)
    }
    
    func getTimeline(in context: Context, completion: @escaping (Timeline<SimpleEntry>) -> Void) {
        // Create a timeline entry for "now."
        let date = Date()
        let entry = SimpleEntry(
            date: date,
            pet: readContents()
        )
        
        // Create the timeline with the entry and a reload policy with the date
        // for the next update.
        let timeline = Timeline(
            entries:[entry],
            policy: .never
        )
        
        // Call the completion to pass the timeline to WidgetKit.
        completion(timeline)
    }
    
    func readContents() -> Pet {
        let archiveURL = FileManager.sharedDocumentsDirectory.appendingPathComponent("SavedData")
        
        let decoder = JSONDecoder()
        if let data = try? Data(contentsOf: archiveURL) {
            do {
                let contents = try decoder.decode(Pet.self, from: data)
                return contents
            } catch {
                print("Error: Can't decode contents")
            }
        }
        return Pet(name: "", bio: "", birthday: Date(), lastMeal: Date(), lastDrink: Date(), body: "", accessory: "", head: "", glasses: "")
    }
    
}
