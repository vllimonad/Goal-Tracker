//
//  NewGoalStorageProtocol.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 29/09/2025.
//

import Foundation

@MainActor
protocol NewGoalStorageProtocol {
    
    func insertModel(_ model: GoalModel) throws
}
