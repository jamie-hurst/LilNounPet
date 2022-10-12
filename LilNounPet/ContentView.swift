//
//  ContentView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI
import ConfettiSwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var vm = ViewModel()
    
    @State private var thirstConfetti = 0
    @State private var hungerConfetti = 0

    
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        NavigationView {
            Form {
                ImageView()
                    .listRowInsets(.init(top: 0, leading: 0, bottom: 0, trailing: 0))
                
                if vm.pet.isAlive {
                    StatsView()
                } else {
                    DeathView()
                }
            }
            .environmentObject(vm)
            .navigationTitle(vm.pet.name)
            .sheet(isPresented: $vm.isShowingHatchView) {
                HatchView(isShowingHatchView: $vm.isShowingHatchView, tokenID: $vm.tokenID)
                    .environmentObject(vm)
                    .interactiveDismissDisabled(true)
            }
            .sheet(isPresented: $vm.isShowingEditView) {
                EditView(chosenBackground: $vm.chosenBackground, chosenTheme: $vm.chosenTheme)
                    .environmentObject(vm)
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button { vm.isShowingEditView = true } label: {
                        Label("profile", systemImage: "face.smiling")
                            .foregroundColor(.primary)
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        vm.feed()
                        vm.hapticSuccess()
                        hungerConfetti += 1
                    } label: {
                        Label("Feed", systemImage: "fork.knife.circle")
                            .foregroundColor(vm.pet.isAlive ? .primary : nil)
                            .font(.title2)
                    }
                    .disabled(!vm.pet.isAlive)
                    .confettiCannon(counter: $hungerConfetti)

                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        vm.giveWater()
                        vm.hapticSuccess()
                        thirstConfetti += 1
                    } label: {
                        Label("Give water", systemImage: "drop")
                            .foregroundColor(vm.pet.isAlive ? .primary : nil)
                            .font(.title2)
                    }
                    .disabled(!vm.pet.isAlive)
                    .confettiCannon(counter: $thirstConfetti)

                }
            }
            .onReceive(timer) { _ in
                vm.saveData()
            }
        }
    }
    
    
    //Custom font for NavigationTitle
    init() {
        UINavigationBar.appearance().largeTitleTextAttributes = [.font : UIFont(name: "LondrinaSolid-Regular", size: 40)!]
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
