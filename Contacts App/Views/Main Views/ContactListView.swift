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
    @State private var showMore = false
    @State private var currentContact: Contact = Contact()
    @State private var isShowingAddContactSheet = false
    @State private var selectedFilter: Filter = .none
    
    
    // Filter and Predicate - Advanced Queries
    @Query(filter: #Predicate<Contact> {
        $0.email.contains("@example.com")
    } ) private var contactsWithExampleDomain: [Contact]
    
    @Query(filter: #Predicate<Contact> {
        !$0.phoneNumber.isEmpty
    } ) private var contactsWithPhoneNumber: [Contact]
    
    @Query(filter: #Predicate<Contact> {
        $0.lastName.starts(with: "A")
    } ) private var contactsStartingWithA: [Contact]
    
    
    // Filtered Contacts
    var filteredContacts: [Contact] {
        let baseContacts: [Contact]
        switch selectedSortOrder {
        case .firstName:
            baseContacts = contactsByFirstName
        case .lastName:
            baseContacts = contactsByLastName
        case .phoneNumber:
            baseContacts = contactsByPhoneNumber
        }
        
        var theFilterContacts: [Contact]
        switch selectedFilter {
        case .none:
            theFilterContacts = baseContacts
        case .examleDomain:
            theFilterContacts = contactsWithExampleDomain
        case .withPhoneNumber:
            theFilterContacts = contactsWithPhoneNumber
        case .startingWithA:
            theFilterContacts = contactsStartingWithA
        }
        
        // Reverse
        if isSortOrderInverse {
            theFilterContacts = theFilterContacts.reversed()
        }
     
        
        
        
        if searchText.isEmpty {
            return theFilterContacts
        } else {
            return theFilterContacts
                .filter { contact in
                    contact.firstName
                        .localizedCaseInsensitiveContains(searchText) ||
                    
                    contact.lastName
                        .localizedCaseInsensitiveContains(searchText) ||
                    
                    contact.address
                        .localizedCaseInsensitiveContains(searchText) ||
                    
                    contact.phoneNumber
                        .localizedCaseInsensitiveContains(searchText) ||
                    
                    contact.email
                        .localizedCaseInsensitiveContains(searchText)
                    
              }
          }
     }
    
    var body: some View {
        NavigationStack {
            VStack {
               if !filteredContacts.isEmpty {
                TextField("Search Contacts", text: $searchText)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                 
                    SortAndToggleView(
                        selectedSortOrder: $selectedSortOrder,
                        isSortOrderInverse: $isSortOrderInverse
                    )
                    
                    if isAdvancedShown {
                        FilterPickerView(selectedFilter: $selectedFilter)
                    }
                }
                
                
                if filteredContacts.isEmpty {
                    ContentUnavailableView("Enter a new Contact", systemImage: "person.crop.circle.badge.xmark")
                } else {
                    List {
                        ForEach(filteredContacts) { contact in
                            ContactRowItemView(
                                contact: contact,
                                showMore: showMore
                            )
                            .onTapGesture {
                                currentContact = contact
                                isShowingAddContactSheet.toggle()
                                
                            }
                        }
                        .onDelete { indexSet in
                            indexSet
                                .forEach { index in
                                    modelContext.delete(filteredContacts[index])
                          }
                            do {
                                try modelContext.save()
                            } catch {
                                print("Failed to save cotext after deletion \(error)")
                            }
                       }
                    }
                }
                
                
            }
            .sheet(
                isPresented: $isShowingAddContactSheet,
                content: {
                    ContactFormView(
                        contact: $currentContact) { newContact in
                            modelContext.insert(currentContact)
                            
                            try? modelContext.save()
                            isShowingAddContactSheet.toggle()
                        }
            })
            .navigationTitle("Contacts")
                .toolbar {
                    
                    ToolbarItem(placement: .topBarLeading) {
                        Button {
                            showMore.toggle()
                        } label: {
                            Label("Advanced", systemImage: showMore ? "text.book.closed" : "book")
                        }

                    }
                    
                    ToolbarItemGroup(placement: .topBarTrailing) {
                        Button {
                            isAdvancedShown.toggle()
                            if !isAdvancedShown {
                                selectedSortOrder = .firstName
                                selectedFilter = .none
                            }
                        } label: {
                            Label("Advanced", systemImage: isAdvancedShown ? "wand.and.stars" : "wand.and.stars.inverse")
                        }
                        
                        // Add
                        Button {
                            currentContact = Contact()
                            isShowingAddContactSheet.toggle()
                            
                        } label: {
                            Label("Add Contact", systemImage: "plus")
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
