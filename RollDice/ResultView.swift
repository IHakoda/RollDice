//
//  ResultView.swift
//  RollDice
//
//  Created by mr. Hakoda on 26.02.2021.
//

import SwiftUI

struct ResultView: View {
    @FetchRequest(entity: Die.entity(), sortDescriptors: [NSSortDescriptor(keyPath: \Die.date, ascending: true)], predicate: nil) var result: FetchedResults<Die>
    
    var body: some View {
        NavigationView {
            List {
                ForEach(result.reversed(), id: \.self) { die in
                    HStack {
                        if die.one != nil {
                            Image(systemName: die.one ?? "")
                        }
                        if die.two != nil {
                            Image(systemName: die.two ?? "")
                        }
                        if die.three != nil {
                            Image(systemName: die.three ?? "")
                        }
                        if die.four != nil {
                            Image(systemName: die.four ?? "")
                        }
                        if die.five != nil {
                            Image(systemName: die.five ?? "")
                        }
                    }
                }
            }
            
            .navigationBarTitle("Result")
        }
    }
}

struct ResultView_Previews: PreviewProvider {
    static var previews: some View {
        ResultView()
    }
}
