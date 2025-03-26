//
//  ContactRowItemView.swift
//  Contacts App
//
//  Created by Terje Moe on 24/03/2025.
//

import SwiftUI

struct ContactRowItemView: View {
    let contact: Contact
    let showMore: Bool
    
    var showAddressPhoneButton: Bool {
        !contact.phoneNumber.isEmpty || !contact.address.isEmpty
    }
    
    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            HStack {
                
                AvatarContactView(contact: contact)
                
                NameAndEmailView(contact: contact)
                
            }.frame(maxWidth: .infinity, alignment: .leading)
            
            if showMore {
                VStack(alignment: .leading, spacing: 10) {
                    if !contact.phoneNumber.isEmpty {
                        HStack {
                            Image(systemName: "phone.fill")
                                .foregroundStyle(.blue)
                            Text(contact.phoneNumber)
                                .foregroundStyle(.primary)
                        }
                    }
                    
                    if !contact.address.isEmpty {
                        HStack {
                            Image(systemName: "house.fill")
                                .foregroundStyle(.blue)
                                .padding(.top, 2)
                            Text(contact.address)
                                .foregroundStyle(.primary)
                                .lineLimit(3)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    ContactRowItemView(
        contact: .init(
            firstName: "John",
            lastName: "Doe",
            email: "john.doe@exaple.com",
            phoneNumber: "123-456-7890",
            address: "123 Main ST, Springfield, IL",
            avatar: nil
        ),
        showMore: true
    )
    .padding()
}
