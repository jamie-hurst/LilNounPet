//
//  ContentView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI

struct ContentView: View {
    @Environment(\.colorScheme) var colorScheme
    @StateObject private var vm = ViewModel()
    
    private let timer = Timer.publish(every: 5, on: .main, in: .common).autoconnect()
    
    
    var body: some View {
        NavigationView {
            Form {
                ImageView()
                
                if vm.pet.isAlive {
                    StatsView()
                } else {
                    DeathView()
                }
            }
            .environmentObject(vm)
            .navigationTitle(vm.pet.name)
            .sheet(isPresented: $vm.isShowingHatchView) {
                HatchView(isShowingHatchView: $vm.isShowingHatchView)
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
                            .foregroundColor(vm.pet.isAlive ? (colorScheme == .dark ? vm.darkThemes[vm.chosenTheme] : vm.lightThemes[vm.chosenTheme]) : nil)
                            .font(.title2)
                    }
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        vm.feed()
                        vm.hapticSuccess()
                    } label: {
                        Label("Feed", systemImage: "fork.knife.circle")
                            .foregroundColor(vm.pet.isAlive ? (colorScheme == .dark ? vm.darkThemes[vm.chosenTheme] : vm.lightThemes[vm.chosenTheme]) : nil)
                            .font(.title2)
                    }
                    .disabled(!vm.pet.isAlive)
                }
                ToolbarItem(placement: .bottomBar) {
                    Button {
                        vm.giveWater()
                        vm.hapticSuccess()
                    } label: {
                        Label("Give water", systemImage: "drop")
                            .foregroundColor(vm.pet.isAlive ? (colorScheme == .dark ? vm.darkThemes[vm.chosenTheme] : vm.lightThemes[vm.chosenTheme]) : nil)
                            .font(.title2)
                    }
                    .disabled(!vm.pet.isAlive)
                }
            }
            .onReceive(timer) { _ in
                vm.saveData()
            }
        }
//        .preferredColorScheme(.dark)
    }
    
}


struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
