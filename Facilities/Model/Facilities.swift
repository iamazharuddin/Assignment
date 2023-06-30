//
//  Facilities.swift
//  Facilities
//
//  Created by Azharuddin 1 on 28/06/23.
//

import Foundation
// MARK: - Facilities
struct Facilities: Codable {
    let facilities: [Facility]
    let exclusions: [[Exclusion]]
}

// MARK: - Exclusion
struct Exclusion: Codable {
    let facilityID, optionsID: String

    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case optionsID = "options_id"
    }
}


// MARK: - Option
struct FacilityOption: Codable {
    let name, icon, id: String
}


// MARK: - Facility
struct Facility: Codable {
    let facilityID, name: String
    let options: [FacilityOption]
    enum CodingKeys: String, CodingKey {
        case facilityID = "facility_id"
        case name, options
    }
}


