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
                        .foregroundColor(.primary)
                        .padding(.top, 16)
                    
                    ForEach(facility.options, id: \.id) { option in
                        Button(action: {
                            viewModel.handleSelectionChange(facilityId: facility.facilityID, optionId: option.id)
                        }) {
                            HStack(spacing: 8) {
                                Image(option.icon)
                                    .resizable()
                                    .aspectRatio(contentMode: .fit)
                                    .frame(width: 20, height: 20)
                                
                                Text(option.name)
                                    .font(.body)
                                    .foregroundColor(.primary)
                                
                                Spacer()
                                
                                if viewModel.isSelected(facilityId: facility.facilityID, optionId: option.id) {
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                            .padding(.horizontal, 16)
                            .padding(.vertical, 8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .fill(Color.secondary.opacity(viewModel.disabledOptions.contains(option.id) ? 0.2 : 1.0))
                            )
                        }                 .disabled(viewModel.disabledOptions.contains(option.id))
                    }
                }
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            }
        }
        .padding(.vertical, 16)
        .overlay {
            if viewModel.isLoading {
                ProgressView()
            }
        }
    }
}
