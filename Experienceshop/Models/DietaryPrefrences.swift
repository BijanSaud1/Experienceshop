//
//  DietaryPrefrences.swift
//  Experienceshop
//
//  Created by Bijan Saud on 1/5/25.
//

import Foundation

struct DietaryPreferences: Codable {
    var userId: String
    var allergies: [String]
    
    // Convert DietaryPreferences to dictionary for Firestore
    func toDictionary() -> [String: Any] {
        return [
            "userId": userId,
            "allergies": allergies
        ]
    }
}
