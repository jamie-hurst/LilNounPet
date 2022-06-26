//
//  Helpers.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI

func calcTimeSince(date: Date) -> Int {
    let seconds = Int(-date.timeIntervalSinceNow)
    return seconds
}

extension FileManager {
    static var documentsDirectory: URL {
        // find all possible documents directories for this user
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        // just send back the first one, which ought to be the only one
        return paths[0]
    }
}

extension ShapeStyle where Self == Color {
    
    static var dracWhite: Color {
        Color(red: 0.9725490196078431, green: 0.9725490196078431, blue: 0.9490196078431372)
    }
    
    static var dracBackground: Color {
        Color(red: 0.11372549019607843, green: 0.11764705882352941, blue: 0.14901960784313725)
    }
    
    static var dracPurple: Color {
        Color(red: 0.5843137254901961, green: 0.5019607843137255, blue: 1.0)
    }
    
    static var dracGreen: Color {
        Color(red: 0.5411764705882353, green: 1.0, blue: 0.5019607843137255)
    }

    static var dracCyan: Color {
        Color(red: 0.5019607843137255, green: 1.0, blue: 0.9176470588235294)
    }
    
    static var dracPink: Color {
        Color(red: 1.0, green: 0.5019607843137255, blue: 0.7490196078431373)
    }

    static var dracOrange: Color {
        Color(red: 1.0, green: 0.792156862745098, blue: 0.5019607843137255)
    }
    
    static var dracRed: Color {
        Color(red: 1.0, green: 0.5843137254901961, blue: 0.5019607843137255)
    }

    static var dracYellow: Color {
        Color(red: 1.0, green: 1.0, blue: 0.5019607843137255)
    }

}
