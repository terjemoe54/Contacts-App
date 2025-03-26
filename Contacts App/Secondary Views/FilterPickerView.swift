//
//  FilterPickerView.swift
//  Contacts App
//
//  Created by Terje Moe on 26/03/2025.
//

import SwiftUI

struct FilterPickerView: View {
    @Binding var selectedFilter: Filter

    var body: some View {
        Picker("Filter by", selection: $selectedFilter) {
            Text("Domain")
                .tag(Filter.examleDomain)
            
            Text("Has Phone")
                .tag(Filter.withPhoneNumber)
            
            Text("Starts with 'A'")
                .tag(Filter.startingWithA)
            
        }.pickerStyle(SegmentedPickerStyle())
            .padding()
    }
}

#Preview {
    FilterPickerView(selectedFilter: .constant(.examleDomain))
       
}
