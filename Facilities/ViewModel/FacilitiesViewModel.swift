//
//  FacilitiesViewModel.swift
//  Facilities
//
//  Created by Azharuddin 1 on 28/06/23.
//

import Foundation
class FacilitiesViewModel : ObservableObject {
    @Published var selectedFaciltiyDic = [String:String]() // FacilityId to OptionId
    @Published var facilities = [Facility]() // List of facilities
    @Published var isLoading = false
    @Published var disabledOptions = Set<String>() // store optionId
    @Published var exclusionDictionary = [String: Set<String>]() // faciltyId + optionId => set of excluded of optionss
    init(){
        fetchFacilitiesData()
    }
    
    func fetchFacilitiesData(){
        let urlString = "https://my-json-server.typicode.com/iranjith4/ad-assignment/db"
        guard let url = URL(string: urlString) else { return  }
        isLoading = true
        APICallManager().fetchData(url: url, type: Facilities.self) { [weak self] response in
            guard let self = self else { return }
            self.isLoading = false
            switch response {
            case .success(let facilities):
                    self.facilities = facilities.facilities
                    self.initializeExclusionDictionary(exclusions: facilities.exclusions)
            case .failure(let error):
                print(error.localizedDescription)
            }
        }
    }
    
    // Initialize the exclusion dictionary
    private func initializeExclusionDictionary(exclusions: [[Exclusion]]) {
        for exclusionGroup in exclusions {
            let firstExclusion = exclusionGroup.first!
            let secondExclusion = exclusionGroup.last!
            let firstKey = firstExclusion.facilityID + "||" + firstExclusion.optionsID
            let secondKey = secondExclusion.facilityID + "||" + secondExclusion.optionsID
            exclusionDictionary[firstKey, default: []].insert(secondExclusion.optionsID)
            exclusionDictionary[secondKey, default: []].insert(firstExclusion.optionsID)
        }
    }
    
    
    // Implement exclusion logic based on user selections
    func handleSelectionChange(facilityId: String, optionId: String) {
        disabledOptions.removeAll()
        let key = facilityId + "||" + optionId
        if let  optionIds = exclusionDictionary[key]{
           disabledOptions = optionIds
        }
        selectedFaciltiyDic[facilityId] = optionId
    }
    
    func isSelected(facilityId: String, optionId: String) -> Bool{
        guard let  selectedOptionId = selectedFaciltiyDic[facilityId]  else {
            return false
        }
        return  selectedOptionId == optionId &&  disabledOptions.contains(optionId) == false
    }
    
}

