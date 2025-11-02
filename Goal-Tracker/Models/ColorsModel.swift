//
//  ColorsModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 02/11/2025.
//

import Foundation
import SwiftData

@Model
class ColorsModel {
    
    var progress: ColorModel
    
    var background: ColorModel
    
    var text: ColorModel
    
    init(
        progress: ColorModel,
        background: ColorModel,
        text: ColorModel
    ) {
        self.progress = progress
        self.background = background
        self.text = text
    }
    
    convenience init() {
        self.init(
            progress: ColorModel(red: 0.90, green: 0.94, blue: 1.0),
            background: ColorModel(color: .blue),
            text: ColorModel(color: .black)
        )
    }
}

