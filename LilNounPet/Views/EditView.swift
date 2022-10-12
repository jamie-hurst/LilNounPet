//
//  EditView.swift
//  LilNounPet
//
//  Created by Jameson Hurst on 6/25/22.
//

import SwiftUI
import WidgetKit

struct EditView: View {
    @EnvironmentObject var vm : ViewModel
    @Environment(\.dismiss) var dismiss
    @Environment(\.colorScheme) var colorScheme
    
    @Binding var chosenBackground: Int
    @Binding var chosenTheme: Int
    
    var body: some View {
        
        NavigationView {
            Form {
                Section("Name") {
                    TextField("", text: $vm.pet.name)
                        .keyboardType(.alphabet)
                        .disableAutocorrection(true)
                        .autocapitalization(.none)
                }
                
                Section("Bio") {
                    TextField("", text: $vm.pet.bio, axis: .vertical)
                }
                
                Section {
                    Picker("Background", selection: $chosenBackground) {
                        ForEach(0..<vm.backgroundsArray.count, id: \.self) {
                            Text("\(vm.backgroundsArray[$0])")
                        }
                    }
                    .pickerStyle(.automatic)
                }
                
                
                Section {
                    NavigationLink("Edit Traits", destination: BuilderView())
                }
                
                Section {
                    NavigationLink("How to Play", destination: HowToView())
                }
                
                
                
                Button(role: .destructive) {
                    vm.resetData()
                    dismiss()
                } label: {
                    Text("Erase all data")
                }
            }
            .navigationTitle(vm.pet.name)
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                Button("Done") {
                    vm.saveData()
                    WidgetCenter.shared.reloadAllTimelines()
                    dismiss()
                }
            }
        }
        
        
        
    }
}

//struct EditView_Previews: PreviewProvider {
//    static var previews: some View {
//        EditView(chosenBackground: $0, chosenTheme: .$chosenTheme)
//            .environmentObject(ViewModel())
//    }
//}
