//
//  JsonDecoder.swift
//  Arabic-Language
//
//  Created by Zohair on 22/12/2024.
//

import UIKit


struct JsonDataDecoder{
    
    static func loadJSONData(completion: @escaping ([CategoryWords]?) -> Void){
        DispatchQueue.global(qos: .background).async {
            guard let fileURL = Bundle.main.url(forResource: "ArabicWords", withExtension: "json") else {
                print("File path not found for json decode")
                return
            }
            do {
                let data = try Data(contentsOf: fileURL)
                let decoder = JSONDecoder()
                let decodedData = try decoder.decode([CategoryWords].self, from: data)
                DispatchQueue.main.async {
                    completion(decodedData)
                }
            } catch {
                DispatchQueue.main.async {
                    print("Json data decoding error: \(error.localizedDescription)")
                    completion(nil)
                }
            }
        }
    }
    
}
