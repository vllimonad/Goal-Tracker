//
//  CustomTextField.swift
//  GoalTracker
//
//  Created by Vlad Klunduk on 07/02/2026.
//

import SwiftUI

struct CustomTextField: View {
    
    var title: LocalizedStringKey
    var maxCharCount: Int
    
    @Binding var value: String
    @Binding var error: String?
    
    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title)
                .font(.callout.bold())
                .foregroundStyle(Color.secondary)
                .padding(.leading)
            
            VStack(alignment: .leading, spacing: 10) {
                TextField("new.goal.name.field.placeholder", text: $value)
                    .onChange(of: value) { oldValue, newValue in
                        error = nil
                        
                        if newValue.count > maxCharCount {
                            value = oldValue
                        }
                    }
                    .keyboardType(.default)
                
                if let error = error {
                    Text(error)
                        .font(.caption)
                        .foregroundStyle(.red)
                }
            }
            .padding(18)
            .background(Color.bgModalPrimary)
            .clipShape(RoundedRectangle(cornerRadius: 28))
            .animation(.easeOut, value: error)
        }
    }
}

#Preview {
    CustomTextField(
        title: "Name",
        maxCharCount: 20,
        value: .constant("name"),
        error: .constant(nil)
    )
}
