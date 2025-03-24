//
//  CustomTextField.swift
//  Contacts App
//
//  Created by Terje Moe on 24/03/2025.
//

import SwiftUI

struct CustomTextField: View {
    let title: String
    let hint: String
    @Binding var value: String
    var onChange: () -> ()
    @FocusState private var isActive: Bool
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title)
                .font(.caption2)
            
            TextField(hint, text: $value)
                .padding(.horizontal, 15)
                .padding(.vertical, 12)
                .autocorrectionDisabled(true)
                .background(
                    RoundedRectangle(cornerRadius: 10)
                        .stroke(isActive ? .blue : .gray.opacity(0.5), lineWidth: 1.5)
                )
                .focused($isActive)
        }
    }
}

#Preview {
    CustomTextField(
        title: "First Name",
        hint: "Enter First Name",
        value: .constant("Name"),
        onChange: {}
    )
    .padding()
}
