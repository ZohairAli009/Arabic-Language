//
//  CodeHelper.swift
//  Arabic-Language
//
//  Created by Zohair on 18/11/2024.
//

import UIKit
import AVFoundation

let speechSynthesizer = AVSpeechSynthesizer()
var audioPlayer: AVAudioPlayer?

struct CodeHelper {
    
    static func addGradientToView(_ targetView: UIView, colors: [UIColor], radius: CGFloat) {
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = targetView.bounds
        gradientLayer.colors = colors.map {$0.cgColor}
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 1.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 0.0) // Horizontal gradient
        gradientLayer.cornerRadius = radius
        targetView.layer.insertSublayer(gradientLayer, at: 0)
    }

    
    static func valuesToUIColor(values: [CGFloat]) -> UIColor{
        let red = values[0]   / 255
        let green = values[1] / 255
        let blue = values[2]  / 255
        return UIColor.init(red: red, green: green, blue: blue, alpha: 1)
    }
    
    
    static func translateArabicWord(_ arabicWord: String) -> String {
        let transliterationMap: [Character: String] = [
            "ا": "a", "ب": "b", "ت": "t", "ث": "th", "ج": "j",
            "ح": "h", "خ": "kh", "د": "d", "ذ": "dh", "ر": "r",
            "ز": "z", "س": "s", "ش": "sh", "ص": "s", "ض": "d",
            "ط": "t", "ظ": "z", "ع": "ʿ", "غ": "gh", "ف": "f",
            "ق": "q", "ك": "k", "ل": "l", "م": "m", "ن": "n",
            "ه": "h", "و": "w", "ي": "i", "ء": "'", "أ": "a",
            "إ": "i", "ؤ": "u", "ئ": "i", "ى": "a", "ة": "a"
        ]
        
        var phoneticWord = ""
        for char in arabicWord {
            phoneticWord += transliterationMap[char] ?? String(char)
        }
        return "[\(phoneticWord)]"
    }
    
    
    static func getSelectedWordsLists() -> [[String]] {
        guard let wordsDict = UserDefaults.standard.dictionary(forKey: "selectedWords") else {
            return []
        }
        let keys = wordsDict.keys.compactMap { $0 as String }
        let values = wordsDict.values.compactMap { $0 as? String }
        return [keys, values]
    }

    
    static func configureAVAudioSession(){
        // Configure audio session for playback
        let audioSession = AVAudioSession.sharedInstance()
        try? audioSession.setCategory(.playback, mode: .default, options: .duckOthers)
        try? audioSession.setActive(true, options: .notifyOthersOnDeactivation)
    }
    

    static func speakArabicWord(word: String, speech: String){
        configureAVAudioSession()
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "ar-SA")
        if speech == "fast"{
            utterance.rate = 0.5
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                speechSynthesizer.speak(utterance)
            })
        }
        else if speech == "slow"{
            utterance.rate = 0.1
            DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
                speechSynthesizer.speak(utterance)
            })
        }
    }
    
    static func speakEnglishWord(word: String){
        configureAVAudioSession()
        let utterance = AVSpeechUtterance(string: word)
        utterance.voice = AVSpeechSynthesisVoice(language: "en-GB")
        utterance.rate = 0.5
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.3, execute: {
            speechSynthesizer.speak(utterance)
        })
    }
    
    
    static func playSound(soundUrl: URL) {
        configureAVAudioSession()
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: soundUrl)
            audioPlayer?.prepareToPlay()
            audioPlayer?.volume = 0.35
            audioPlayer?.rate = 1.2
            audioPlayer?.play()
        } catch {
            print("Error playing sound: \(error.localizedDescription)")
        }
    }
    
    
    
    static func splitWordIntoLetters(_ word: String) -> [String]{
        var letters = [String]()
        for char in word{
            letters.append(String(char))
        }
        return letters.shuffled()
    }
    
    
    // MARK: - Calendar
    static func getDatesOfCurrentWeek(currentDate: Date) -> [String: [String]] {
        let calendar = Calendar.current
        
        // Find the start of the current week
        let startOfWeek = calendar.dateInterval(of: .weekOfMonth, for: currentDate)?.start
        
        // If we have the start of the week, create an array with all dates of the week
        var datesOfWeek: [Date] = []
        if let startOfWeek = startOfWeek {
            for day in 0..<7 {
                if let date = calendar.date(byAdding: .day, value: day, to: startOfWeek) {
                    datesOfWeek.append(date)
                }
            }
        }
        
        var stringDates: [String] = []
        let dateFormatterForMonth = DateFormatter()
        dateFormatterForMonth.dateFormat = "MMMM"
        
        let dateFormatterForDates = DateFormatter()
        dateFormatterForDates.dateFormat = "d"
        
        var month = ""
        if let firstDate = datesOfWeek.first {
            month = dateFormatterForMonth.string(from: firstDate)
        }
        for date in datesOfWeek {
            stringDates.append(dateFormatterForDates.string(from: date))
        }
        
        return ["\(month)": stringDates]
    }
    
    static func currentDateString() -> String {
        let currentDate = Date()
        let dateFormetter = DateFormatter()
        dateFormetter.dateStyle = .medium
        dateFormetter.timeStyle = .none
        dateFormetter.dateFormat = "d"
        
        return dateFormetter.string(from: currentDate)
    }
    
    
    static func currentDate() -> Date{
        let currentDate = Date()
        let calendar = Calendar.current
        let dateOnly = calendar.startOfDay(for: currentDate)
        return dateOnly
    }
    
    
    static func getDifferenceBetweenDates(current: Date, previous: Date) -> Int{
        let calendar = Calendar.current
        let components = calendar.dateComponents([.day], from: current, to: previous)
        guard let days = components.day else { return 0}
        let savedCount = UserDefaults.standard.integer(forKey: "installDayCount")
        let newCount = savedCount + abs(days)
        UserDefaults.standard.set(newCount , forKey: "installDayCount")
        return newCount
    }
}

