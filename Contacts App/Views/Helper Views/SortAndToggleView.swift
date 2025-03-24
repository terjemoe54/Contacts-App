//
//  SortAndToggleView.swift
//  Contacts App
//
//  Created by Terje Moe on 24/03/2025.
//

import SwiftUI

struct SortAndToggleView: View {
    @Binding var selectedSortOrder: SortOrder
    @Binding var isSortOrderInverse: Bool
    
    var degrees: CGFloat {
        isSortOrderInverse ? 180 : 0
    }
    
    var body: some View {
        HStack {
            Picker("Sorted By", selection: $selectedSortOrder)
                    {
                Text("First Name")
                    .tag(SortOrder.firstName)
                Text("Last Name")
                    .tag(SortOrder.lastName)
                Text("Phone Number")
                    .tag(SortOrder.phoneNumber)
                    }.pickerStyle(SegmentedPickerStyle())
            
            Image(systemName: "arrowshape.down.fill")
                .foregroundStyle(.blue)
                .rotationEffect(.degrees(degrees))
                .animation(.spring, value: isSortOrderInverse)
                .onTapGesture {
                    isSortOrderInverse.toggle()
                }
        }
        .padding()
    }
}

#Preview {
    SortAndToggleView(
        selectedSortOrder: .constant(.firstName),
        isSortOrderInverse: .constant(true)
    )
}
