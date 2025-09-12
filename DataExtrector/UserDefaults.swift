//
//  UserDefaults.swift
//  Arabic-Language
//
//  Created by Zohair on 15/12/2024.
//

import UIKit


struct userDefaults{
    
    static func getProgressData() -> ProgressData{
        do{
            if let savedData = UserDefaults.standard.data(forKey: "ProgressData"){
                let progressList = try JSONDecoder().decode(ProgressData.self, from: savedData)
                return progressList
            }
        }catch{
            print("failed to retrieve data from userdefaults: \(error.localizedDescription)")
        }
        return ProgressData()
    }
    
    
    static func updateProgressData(data: ProgressData, _ progressByCategoryType: Int) {
        do {
            // Retrieve existing data from UserDefaults or initialize an empty ProgressData
            var retrievedData = try UserDefaults.standard.data(forKey: "ProgressData")
                .flatMap { try JSONDecoder().decode(ProgressData.self, from: $0) } ?? ProgressData()

            // Merge new data into the existing data
            retrievedData.alreadyKnown.merge(data.alreadyKnown) { _, new in new }
            retrievedData.difficult.merge(data.difficult) { _, new in new }

            // Update progress by category based on the given type
            switch progressByCategoryType {
            case 1:
                retrievedData.progressByCategory.merge(data.progressByCategory) { current, _ in current + 1 }
            case 2:
                retrievedData.progressByCategory.merge(data.progressByCategory) { current, new in current + new }
            default:
                break
            }

            // Save the updated data back to UserDefaults
            let updatedData = try JSONEncoder().encode(retrievedData)
            UserDefaults.standard.set(updatedData, forKey: "ProgressData")
        } catch {
            print("Failed to update data in UserDefaults: \(error.localizedDescription)")
        }
    }
}
