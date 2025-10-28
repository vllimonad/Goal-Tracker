import SwiftUI

extension View {
    func systemShadow() -> some View {
        self
            .shadow(color: Color.black.opacity(0.06),
                    radius: 10,
                    x: 0,
                    y: 0)
    }
}
