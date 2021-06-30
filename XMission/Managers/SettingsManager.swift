//
//  SettingsManager.swift
//  XMission
//
//  Created by Natallia Valadzko on 28.01.21.
//

import Foundation
import SpriteKit

    //MARK: - Enum
enum SettingKeys: String {
    case settingsKey
}

    //MARK: - SettingsManager
class SettingsManager {
    
    //MARK: - Constants
    static let shared = SettingsManager()
    
    //MARK: - Initializer
    private init() {}
    
    //MARK: - Flow Functions
    func saveSettings(_ settings: Settings) {
        UserDefaults.standard.set(encodable: settings, forKey: SettingKeys.settingsKey.rawValue)
    }
    
    func loadSettings() -> Settings {
        guard let settings = UserDefaults.standard.value(Settings.self, forKey: SettingKeys.settingsKey.rawValue) else {
            return Settings(playerName: nil, spaceshipName: nil, timer: nil)
        }
        return settings
    }
}
