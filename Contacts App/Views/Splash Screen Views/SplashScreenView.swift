//
//  SplashScreenView.swift
//  Contacts App
//
//  Created by Terje Moe on 26/03/2025.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var isActive = false
    @State private var scaleEffect = 0.8
    
    var body: some View {
        VStack {
            if isActive {
                ContactListView()
                    .modelContainer(for: Contact.self)
            } else {
                VStack {
                    Image(systemName: "person.crop.circle.fill.badge.plus")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 100, height: 100)
                        .foregroundStyle(.blue)
                        .scaleEffect(scaleEffect)
                        .onAppear{
                            withAnimation(
                                .easeOut(duration: 1.0)) {
                                    scaleEffect = 1.0
                                }
                        }
                    
                    Text("Welcome to Contacts")
                        .font(.largeTitle)
                        .bold()
                        .foregroundStyle(.primary)
                        .padding(.top, 16)
                }
            }
        }
        .onAppear {
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
                withAnimation {
                    isActive = true
                }
            }
        }
    }
}

#Preview {
    SplashScreenView()
}
