//
//  SimpleEntry.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 7/21/22.
//

import WidgetKit

struct SimpleEntry: TimelineEntry, Codable {
    let date: Date
    var pet: Pet
}
