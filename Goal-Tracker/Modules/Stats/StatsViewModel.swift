//
//  StatsViewModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 08/10/2025.
//

import Foundation

@Observable
final class StatsViewModel {
    
    var records: [RecordModel]
    
    init(records: [RecordModel] = []) {
        self.records = records
    }
}
