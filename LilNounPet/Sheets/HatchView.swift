//
//  HatchView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI

struct HatchView: View {
    @EnvironmentObject var vm : ViewModel
    
    @Binding var isShowingHatchView: Bool
    
    var body: some View {
        
        NavigationView {
            Form {
                
                Section("Name") {
                    TextField("What's your pet's name?", text:$vm.pet.name)
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
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("Hatch your pet") {
                        vm.hatchPet()
                    }
                    .disabled(!vm.isHatchViewValid)
                }
            }
            
            
        }
        
        
    }
}

struct HatchView_Previews: PreviewProvider {
    static var previews: some View {
        HatchView(isShowingHatchView: ViewModel().$isShowingHatchView)
            .environmentObject(ViewModel())
    }
}
