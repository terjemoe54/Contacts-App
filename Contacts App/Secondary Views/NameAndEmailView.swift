//
//  NameAndEmailView.swift
//  Contacts App
//
//  Created by Terje Moe on 24/03/2025.
//

import SwiftUI

struct NameAndEmailView: View {
    let contact: Contact
    var body: some View {
        VStack(alignment: .leading, spacing: 5){
            Text(contact.fullName)
                .font(.headline)
                .foregroundStyle(.primary)
            
            Text(contact.email)
                .font(.subheadline)
                .foregroundStyle(.secondary)
            
        }
    }
}

#Preview {
    NameAndEmailView(contact: .init(
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@exaple.com",
        phoneNumber: "123-456-7890",
        address: "123 Main ST, Springfield, IL",
        avatar: nil
    ))
}
