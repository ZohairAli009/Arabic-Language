//
//  TrainingDataModel.swift
//  Arabic-Language
//
//  Created by Zohair on 03/12/2024.
//

import Foundation

// MARK: - Training data of selected words
struct TrainingData {
    var arabicWord: String
    var englishWord: String
    var arabicRandomWords: [String]
    var englishRandomWords: [String]
}

// MARK: - Progress of Words
struct ProgressData: Codable{
    var alreadyKnown: [String: String]
    var difficult: [String: String]
    var progressByCategory: [String: Int]
    
    // Default initializer to create an empty instance
    init(
        alreadyKnown: [String: String] = [:],
        difficult: [String: String] = [:],
        progressByCategory: [String: Int] = [:]
    ) {
        self.alreadyKnown = alreadyKnown
        self.difficult = difficult
        self.progressByCategory = progressByCategory
    }
}

// MARK: - Recommended words
struct RecommendedWordsDataModel{
    var wordInfo: Word 
    var wordsCategory: String
}
