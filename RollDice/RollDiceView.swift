//
//  RollDiceView.swift
//  RollDice
//
//  Created by mr. Hakoda on 26.02.2021.
//

//import CoreData
import SwiftUI

extension AnyTransition {
  static var customTransition: AnyTransition {
    let transition = AnyTransition.move(edge: .top)
      .combined(with: .scale(scale: 0.2, anchor: .topTrailing))
      .combined(with: .opacity)
    return transition
  }
}

struct RollDiceView: View {
    @Environment(\.managedObjectContext) var moc
    
    @State private var showingSettingsView = false
    @State private var animationAmount = 0.0
    @State private var dragAmount = CGSize.zero
    
    @State var setting: Setting

    @State private var imagesPath = [String]()
    
    var body: some View {
        NavigationView {
            ZStack {
                HStack {
                    VStack {
                        ForEach(0..<imagesPath.count, id: \.self) { path in
                            Image(systemName: imagesPath[path])
                                .font(.system(size: 60))
                                .shadow(color: .gray, radius: 4, x: 1, y: 1)
                                .rotation3DEffect(.degrees(animationAmount), axis: (x: .random(in: 0...4), y: .random(in: 0...4), z: .random(in: 0...4)))
                                .offset(dragAmount)
                                //.animation(Animation.easeInOut(duration: 1)
                                            //.repeatCount(3, autoreverses: true))
                        }
                    }
                }
            }
            .gesture(
                DragGesture()
                    .onChanged { self.dragAmount = $0.translation }
                    .onEnded { _ in
                        withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                            self.dragAmount = .zero
                            
                            DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                                if setting.picColor == 0 {
                                    for item in imagesPath {
                                        var newItem = item.dropLast()
                                        newItem.insert(Substring.Element(String(Int.random(in: 1...6))), at: newItem.endIndex)
                                        self.imagesPath.append(String(newItem))
                                        self.imagesPath.remove(at: 0)
                                    }
                                } else {
                                    for itemFill in imagesPath {
                                        //var numbers: [Int]
                                        
                                        let stringArray = itemFill.components(separatedBy: CharacterSet.decimalDigits.inverted)
                                        for item in stringArray {
                                            if let number = Int(item) {
                                                let newItem = itemFill.replacingOccurrences(of: String(number), with: String(Int.random(in: 1...6)))
                                                //newItem.insert(Substring.Element(String(Int.random(in: 1...4))), at: newItem.endIndex)
                                                self.imagesPath.append(String(newItem))
                                                self.imagesPath.remove(at: 0)
                                            }
                                        }
                                    }
                                }
                                
                                let result = Die(context: self.moc)
                                
                                result.date = Date()
                    
                                if self.imagesPath.indices.contains(0) {
                                    result.one = self.imagesPath[0]
                                }
                                if self.imagesPath.indices.contains(1) {
                                    result.two = self.imagesPath[1]
                                }
                                if self.imagesPath.indices.contains(2) {
                                    result.three = self.imagesPath[2]
                                }
                                if self.imagesPath.indices.contains(3) {
                                    result.four = self.imagesPath[3]
                                }
                                if self.imagesPath.indices.contains(4) {
                                    result.five = self.imagesPath[4]
                                }

                                do {
                                    try self.moc.save()
                                } catch {
                                    print(error.localizedDescription)
                                }
                            }
                            
                            //withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                            self.animationAmount += 360
                            //}
                            
                        }
                    }
            )
            .onTapGesture {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.4) {
                    if setting.picColor == 0 {
                        for item in imagesPath {
                            var newItem = item.dropLast()
                            newItem.insert(Substring.Element(String(Int.random(in: 1...6))), at: newItem.endIndex)
                            self.imagesPath.append(String(newItem))
                            self.imagesPath.remove(at: 0)
                        }
                    } else {
                        for itemFill in imagesPath {
                            //var numbers: [Int]
                            
                            let stringArray = itemFill.components(separatedBy: CharacterSet.decimalDigits.inverted)
                            for item in stringArray {
                                if let number = Int(item) {
                                    let newItem = itemFill.replacingOccurrences(of: String(number), with: String(Int.random(in: 1...6)))
                                    //newItem.insert(Substring.Element(String(Int.random(in: 1...4))), at: newItem.endIndex)
                                    self.imagesPath.append(String(newItem))
                                    self.imagesPath.remove(at: 0)
                                }
                            }
                        }
                    }
                    let result = Die(context: self.moc)
                    
                    result.date = Date()
        
                    if self.imagesPath.indices.contains(0) {
                        result.one = self.imagesPath[0]
                    }
                    if self.imagesPath.indices.contains(1) {
                        result.two = self.imagesPath[1]
                    }
                    if self.imagesPath.indices.contains(2) {
                        result.three = self.imagesPath[2]
                    }
                    if self.imagesPath.indices.contains(3) {
                        result.four = self.imagesPath[3]
                    }
                    if self.imagesPath.indices.contains(4) {
                        result.five = self.imagesPath[4]
                    }

                    do {
                        try self.moc.save()
                    } catch {
                        print(error.localizedDescription)
                    }
                    
                }
                
                withAnimation(.interpolatingSpring(stiffness: 5, damping: 1)) {
                    self.animationAmount += 360
                }
                
                
            }
            
            .navigationBarTitle("Roll Die")
            .navigationBarItems(leading: Button(action: {
                self.showingSettingsView = true
            }) {
                Image(systemName: "gearshape")
                    .imageScale(.large)
            })
            .sheet(isPresented: $showingSettingsView, onDismiss: loadData) {
                SettingsView()
            }
            .onAppear(perform: loadData)
        }
    }
    
    func loadData() {
        if let data = UserDefaults.standard.data(forKey: "Setting") {
            if let decoded = try? JSONDecoder().decode(Setting.self, from: data) {
                self.setting = decoded
            }
        }
        self.imagesPath.removeAll()
        
        for die in 0..<(self.setting.countDie + 1) {
            let imagePath = "die.face.\(die + 1)\(self.setting.picColor == 1 ? ".fill" : "")"
            self.imagesPath.append(imagePath)
        }
    }
}

struct RollDiceView_Previews: PreviewProvider {
    static var previews: some View {
        RollDiceView(setting: Setting.example)
    }
}
