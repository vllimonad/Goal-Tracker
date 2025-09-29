import Foundation

@MainActor
protocol NewGoalStorageProtocol {
    
    func insertModel(_ model: GoalModel) throws
}
