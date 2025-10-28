//
//  ColorModel.swift
//  Goal-Tracker
//
//  Created by Vlad Klunduk on 26/09/2025.
//

import Foundation
import SwiftData
import SwiftUI
import UIKit

@Model
class ColorModel {
    
    var red: CGFloat
    var green: CGFloat
    var blue: CGFloat
    var opacity: Double
    
    var color: Color {
        Color(red: red, green: green, blue: blue, opacity: opacity)
    }
    
    convenience init(color: Color) {
        let uiColor = UIColor(color)
        let ciColor = CIColor(color: uiColor)
        
        self.init(red: ciColor.red,
                  green: ciColor.green,
                  blue: ciColor.blue,
                  opacity: ciColor.alpha)
    }
    
    init(red: CGFloat, green: CGFloat, blue: CGFloat, opacity: Double) {
        self.red = red
        self.green = green
        self.blue = blue
        self.opacity = opacity
    }
}
