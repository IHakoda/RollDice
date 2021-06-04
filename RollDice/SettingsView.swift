//
//  SettingsView.swift
//  RollDice
//
//  Created by mr. Hakoda on 26.02.2021.
//

import SwiftUI

struct SettingsView: View {
    @Environment(\.presentationMode) var presentationMode

    @State private var setting = Setting.example
    
    let countDices = ["die.face.1", "die.face.2", "die.face.3", "die.face.4", "die.face.5"]
    let countColors = ["cube", "cube.fill"]
    
    var body: some View {
        NavigationView {
        Form {
            Section(header: Text("How many dice do you want to roll?")) {
                Picker("Pic Dice", selection: $setting.countDie) {
                    ForEach(0..<countDices.count) {
                        Image(systemName: "\(self.countDices[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section(header: Text("What color do you prefer?")) {
                Picker("Pic Dice", selection: $setting.picColor) {
                    ForEach(0..<countColors.count) {
                        Image(systemName: "\(self.countColors[$0])")
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
            }
            Section {
                Button("Save", action: {
                    saveData()
                    dismiss()
                })
            }
        }
        .navigationBarTitle("Settings", displayMode: .inline)
        .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Setting") {
            if let decoded = try? JSONDecoder().decode(Setting.self, from: data) {
                self.setting = decoded
            }
        }
    }
    
    func saveData() {
        if let data = try? JSONEncoder().encode(setting) {
            UserDefaults.standard.set(data, forKey: "Setting")
        }
    }
    
    func dismiss() {
        presentationMode.wrappedValue.dismiss()
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
