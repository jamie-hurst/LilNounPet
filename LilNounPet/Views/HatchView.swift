//
//  HatchView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI
import ConfettiSwiftUI

struct HatchView: View {
    @EnvironmentObject var vm : ViewModel
    
    @Binding var isShowingHatchView: Bool
    @Binding var tokenID: String
    @Binding var mainConfetti: Int
 
    
    var body: some View {
        
        NavigationView {
            Form {
                VStack {
                    HStack {
                        Spacer()
                        Text("Lil Noun Pet")
                            .font(Font.custom("LondrinaSolid-Regular", size: 48, relativeTo: .title))
                        Spacer()
                    }
                    
                    Image("lilnoun-banner-no-bg")
                        .interpolation(.none)
                        .resizable()
                        .scaledToFit()
                }
                .listRowBackground(Color(UIColor.systemGroupedBackground))
                
                
                Section {
                    TextField("Name your Lil Noun", text: $vm.pet.name)
                        .keyboardType(.alphabet)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                    
                    Toggle("Enable notifications", isOn: $vm.isNotificationsEnabled)
                        .onChange(of: vm.isNotificationsEnabled) { _ in
                            if vm.isNotificationsEnabled {
                                vm.requestNotificationAuthorization()
                            }
                        }
                }
                
//                Section("Want to hatch an existing Lil Noun?") {
//                    TextField("Enter your token ID", text: $tokenID)
//                        .keyboardType(.numberPad)
//                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Hatch your pet") {
                        vm.hatchPet()
                        mainConfetti += 1
                        vm.hapticSuccess()
            // implement token ID hatching
//                        Task {
//                            try await vm.hatchPet()
//                            try await vm.assignTokenTraits()
//                        }
                        
                    }
                    .disabled(!vm.isHatchViewValid)
                }
            }
            
            
        }
        
        
    }
}

struct HatchView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        
        
        HatchView(isShowingHatchView: vm.$isShowingHatchView, tokenID: vm.$tokenID, mainConfetti: .constant(0))
            .environmentObject(ViewModel())
    }
}
