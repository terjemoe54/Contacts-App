//
//  ContactListView.swift
//  Contacts App
//
//  Created by Terje Moe on 24/03/2025.
//

import SwiftUI
import SwiftData

struct ContactListView: View {
    @Environment(\.modelContext) private var modelContext
   
    // Queries
    // First name
    @Query(
        sort: \Contact.firstName,
        order: .forward
    )
    private var contactsByFirstName: [Contact]
    // Last name
    @Query(
        sort: \Contact.lastName,
        order: .forward
    )
    private var contactsByLastName: [Contact]
   
    // Phone number
    @Query(
        sort: \Contact.phoneNumber,
        order: .forward
    )
    private var contactsByPhoneNumber: [Contact]
     
  
    @State private var searchText: String = ""
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search Contacts", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
              
                Spacer()
                
            }.navigationTitle("Contacts")
        }
    }
}

#Preview {
    ContactListView()
        .modelContainer(for: Contact.self)
}
