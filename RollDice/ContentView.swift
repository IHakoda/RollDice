//
//  ContentView.swift
//  RollDice
//
//  Created by mr. Hakoda on 26.02.2021.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        TabView {
            RollDiceView(setting: Setting.example)
                .tabItem {
                    Image(systemName: "die.face.5")
                    Text("Roll Dice")
                }
            ResultView()
                .tabItem {
                    Image(systemName: "list.bullet.rectangle")
                    Text("Result")
                }
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
