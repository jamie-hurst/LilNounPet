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
    
    @State private var hatchButtonText = "Hatch Your Pet"
    
    let alertText = AlertText()
    
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
                
                Section("Want to hatch an existing Lil Noun?") {
                    TextField("Enter your token ID", text: $tokenID)
                        .keyboardType(.numberPad)
                }
                
            }
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(hatchButtonText) {
                        // Changes the text of the hatch button to say "Loading"
                        hatchButtonLoading()
                        
                        Task {
                            await vm.hatchPet()
                        }
                    }
                    .disabled(!vm.isPetNameValid || !vm.isTokenEntryValid || hatchButtonText == "Loading")
                    // Fire an alert if there's an error fetching the data
                    .alert(alertText.title, isPresented: $vm.isShowingAlert) {
                        Button("Dismiss", role: .cancel) {
                            withAnimation {
                                // Toggles the button text back to default text
                                hatchButtonDefault()
                            }
                        }
                    } message: {
                        Text(alertText.message)
                    }
                }
            }
            
        }
        
        
    }
    
    func hatchButtonLoading() {
        hatchButtonText = "Loading"
    }
    
    func hatchButtonDefault() {
        hatchButtonText = "Hatch Your Pet"
    }
    
}


struct AlertText {
    let title = "Error Fetching token"
    let message = "There was an error fetching the data for this token ID. Please try again or enter another token ID number."
}

struct HatchView_Previews: PreviewProvider {
    static var previews: some View {
        let vm = ViewModel()
        
        HatchView(isShowingHatchView: vm.$isShowingHatchView, tokenID: vm.$tokenID)
            .environmentObject(ViewModel())
    }
}
