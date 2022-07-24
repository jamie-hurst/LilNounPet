//
//  HowToView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 7/3/22.
//

import SwiftUI

struct HowToView: View {
    var body: some View {
        
        ScrollView {
            Text("Thanks for playing Lil Noun Pet!")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("LondrinaSolid-Regular", size: 24, relativeTo: .title))
                .padding(.bottom)
              
            
            Text("""
                Prevent your Lil Noun’s slow march toward doom by providing it with food and water. Think Tamagotchi, but with Lil Nouns cc0 artwork! Each Lil Noun is randomly generated based on a large set of traits when the pet is hatched. Your pet’s appearance reflects its current state. If your pet is asleep, its eyes will be closed. If your pet dies, its eyes will be crossed out, etc.
                
                Your pet will perish if it hasn't been fed for 24 hours or given water for 12 hours. You can enable notifications to be notified 2 hours before your pet will pass away.
                """)
            .padding(.bottom, 40)
            
            Text("HomeScreen Widget")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.custom("LondrinaSolid-Regular", size: 24, relativeTo: .title))
                .padding(.bottom)
            
            Text("""
                The HomeScreen Widget is under development. The Widget data currently only updates when the main app is opened.
                
                Here's how to add the Lil Noun Pet Widget to your HomeScreen:
                
                1. Then touch and hold the Home Screen background until the apps begin to jiggle.
                2. Tap the Add Widget button at the top of the screen to open the widget gallery.
                3. Scroll or search to find Lil Noun Pet and tap Add Widget.
                4. While the apps are still jiggling, move the widget where you want it on the screen, then tap Done.
                """)
        }
        .padding()
        
        
    }
}

struct HowToView_Previews: PreviewProvider {
    static var previews: some View {
        HowToView()
    }
}
