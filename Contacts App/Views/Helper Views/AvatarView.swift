//
//  AvatarView.swift
//  Contacts App
//
//  Created by Terje Moe on 24/03/2025.
//

import SwiftUI

struct AvatarView: View {
    let contact: Contact
    var body: some View {
        if let avatarData = contact.avatar , let uiImage = UIImage(data: avatarData){
            Image(uiImage: uiImage)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())
                .overlay{
                    Circle().stroke(.gray, lineWidth: 1)
                    }
        } else {
            Circle()
                .fill(.blue.opacity(0.2))
                .frame(width: 50, height: 50)
                .overlay{
                    Text(contact.fullName.uppercased().prefix(1))
                        .font(.largeTitle)
                        .foregroundStyle(.blue)
                        .bold()
                }.padding(.trailing, 10)
        }
    }
}

#Preview {
    AvatarView(contact: .init(
        firstName: "John",
        lastName: "Doe",
        email: "john.doe@exaple.com",
        phoneNumber: "123-456-7890",
        address: "123 Main ST, Springfield, IL",
        avatar: nil
    ))
}
