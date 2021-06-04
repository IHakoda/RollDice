//
//  UserSetting.swift
//  RollDice
//
//  Created by mr. Hakoda on 26.02.2021.
//

import SwiftUI

struct Setting: Codable {
    var countDie: Int
    var picColor: Int
    
    static var example: Setting {
        Setting(countDie: 0, picColor: 0)
    }
}
