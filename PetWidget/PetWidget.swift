//
//  PetWidget.swift
//  PetWidget
//
//  Created by Jameson Hurst on 7/11/22.
//
import WidgetKit
import SwiftUI

@main
struct PetWidget: Widget {
    let kind: String = "PetWidget"
    
    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { entry in
            PetWidgetEntryView(entry: entry)
        }
        .configurationDisplayName("Lil Noun Pet Widget")
        .description("Currently in beta. The widget content will only refresh when the main app is opened.")
        .supportedFamilies([.systemSmall])
    }
}

