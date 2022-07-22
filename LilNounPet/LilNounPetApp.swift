//
//  LilNounPetApp.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI
import WidgetKit

@main
struct LilNounPetApp: App {
    @Environment(\.scenePhase) private var phase
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .onChange(of: phase) { newPhase in
            switch newPhase {
            case .active: refreshWidget()
            case .background: refreshWidget()
            case .inactive: refreshWidget()
            default: break
            }
        }
    }
    
    func refreshWidget() {
        WidgetCenter.shared.reloadAllTimelines()
    }
}
