//
//  RecordsManager.swift
//  HXMission
//
//  Created by Natallia Valadzko on 25.01.21.
//

import Foundation

    //MARK: - Enum
enum RecordsKeys: String {
    case recordsKey
}

    //MARK: - RecordsManager
class RecordsManager {
    
    //MARK: - Constants
    static let shared = RecordsManager()
    
    //MARK: - Flow Fucntions
    func saveRecords(_ records: Record) {
        var array = self.loadRecords()
        array.append(records)
        UserDefaults.standard.set(encodable: array, forKey: RecordsKeys.recordsKey.rawValue)
    }
    
    func loadRecords() -> [Record] {
        guard let records = UserDefaults.standard.value([Record].self, forKey: RecordsKeys.recordsKey.rawValue) else {
            return []
        }
        return records
    }
}
