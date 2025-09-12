//
//  ArabicWorsModel.swift
//  Arabic-Language
//
//  Created by Zohair on 25/11/2024.
//

import Foundation

// MARK: arabic words with more info
struct CategoryWords: Codable {
    let name: String
    let words: [Word]
}

struct Word: Codable {
    let arabic: String
    let english: String
    let part_of_speech: String
    let singular: String
    let plural: String
    let synonyms: [String]
    let grammar_info: GrammarInfo
}

struct GrammarInfo: Codable {
    let usage: String
    let sentence_position: String
}



// MARK: arabic alphabets

struct ArabicLetters: Codable {
    let letter: String
    let name: String
    let forms: Forms
    
    struct Forms: Codable {
        let initial: String
        let medial: String
        let final: String
    }
}

// MARK: arabic counting
struct ArabicCounting: Codable {
    let number: String
    let transliteration: String
}


