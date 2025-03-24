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
    
    // State variables
    @State private var searchText: String = ""
    @State private var selectedSortOrder: SortOrder = .firstName
    @State private var isSortOrderInverse: Bool = false
    @State private var isAdvancedShown: Bool = false
    
    var body: some View {
        NavigationStack {
            VStack {
                TextField("Search Contacts", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                
                
                SortAndToggleView(
                    selectedSortOrder: $selectedSortOrder,
                    isSortOrderInverse: $isSortOrderInverse
                )
                
                if isAdvancedShown {
                    Text("TODO: Filter Picker View")
                }
                
                
                Spacer()
                
            }.navigationTitle("Contacts")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            isAdvancedShown.toggle()
                            if !isAdvancedShown {
                                selectedSortOrder = .firstName
                            }
                        } label: {
                            Label("Advanced", systemImage: isAdvancedShown ? "wand.and.stars" : "wand.and.stars.inverse")
                        }

                    }
                }
        }
    }
}

#Preview {
    ContactListView()
        .modelContainer(for: Contact.self)
}
