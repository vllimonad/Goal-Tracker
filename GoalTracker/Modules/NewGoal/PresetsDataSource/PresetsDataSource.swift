import SwiftUI

struct PresetsDataSource {
    
    static let initialIndex: Int = 0
    
    static func getAll() -> [ColorsModel] {
         [
            ColorsModel(
                progress: ColorModel(color: .blue),
                background: ColorModel(red: 0.90, green: 0.94, blue: 1.0),
                text: ColorModel(color: .black)
            ),
            ColorsModel(
                progress: ColorModel(color: .orange),
                background: ColorModel(red: 1.0, green: 0.95, blue: 0.90),
                text: ColorModel(color: .black)
            ),
            ColorsModel(
                progress: ColorModel(color: .green),
                background: ColorModel(red: 0.92, green: 0.98, blue: 0.93),
                text: ColorModel(color: .black)
            ),
            ColorsModel(
                progress: ColorModel(color: .purple),
                background: ColorModel(red: 0.94, green: 0.92, blue: 0.97),
                text: ColorModel(color: .black)
            ),
            ColorsModel(
                progress: ColorModel(color: .red),
                background: ColorModel(red: 0.98, green: 0.92, blue: 0.92),
                text: ColorModel(color: .black)
            ),
            ColorsModel(
                progress: ColorModel(color: .teal),
                background: ColorModel(red: 0.90, green: 0.97, blue: 0.97),
                text: ColorModel(color: .black)
            ),
            ColorsModel(
                progress: ColorModel(color: .indigo),
                background: ColorModel(red: 0.90, green: 0.91, blue: 0.97),
                text: ColorModel(color: .black)
            ),
            ColorsModel(
                progress: ColorModel(color: .pink),
                background: ColorModel(red: 0.98, green: 0.92, blue: 0.96),
                text: ColorModel(color: .black)
            ),
            ColorsModel(
                progress: ColorModel(color: .yellow),
                background: ColorModel(red: 1.0, green: 0.98, blue: 0.88),
                text: ColorModel(color: .black)
            ),
            ColorsModel(
                progress: ColorModel(red: 0.25, green: 0.5, blue: 1.0),
                background: ColorModel(red: 0.12, green: 0.16, blue: 0.30),
                text: ColorModel(color: .white)
            )
        ]
    }
    
    static func getInitial() -> ColorsModel {
        let presets = getAll()
        
        return presets[initialIndex]
    }
}
