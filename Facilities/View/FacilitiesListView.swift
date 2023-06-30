//
//  FacilitiesListView.swift
//  Facilities
//
//  Created by Azharuddin 1 on 29/06/23.
//

import SwiftUI
struct FacilitiesListView: View {
    @StateObject private var viewModel = FacilitiesViewModel()
    var body: some View {
        VStack {
            ForEach(viewModel.facilities, id: \.facilityID) { facility in
                VStack {
                    Text(facility.name)
                        .font(.title)
                    
                    ForEach(facility.options, id: \.id) { option in
                        Button(action: {
                            // Handle option selection
                            viewModel.handleSelectionChange(facilityId: facility.facilityID, optionId: option.id)
                        }) {
                            HStack {
                                Image(option.icon)
                                Text(option.name)
                                Spacer()
                                
                                
                                if viewModel.isSelected(facilityId: facility.facilityID, optionId: option.id)  {
                                    Image(systemName: "checkmark")
                                }
                            }.padding(.horizontal, 16)
                        }
                        .disabled(viewModel.disabledOptions.contains(option.id))
                    }
                }
            }
        }.overlay {
            if (viewModel.isLoading){
                ProgressView()
            }
        }
    }
}

