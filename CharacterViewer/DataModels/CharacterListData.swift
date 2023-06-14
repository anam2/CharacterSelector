//
//  CharacterListData.swift
//  CharacterViewer
//
//  Created by Admin on 6/13/23.
//

import Foundation
import UIKit

/**
Data model that represents information about a specific Character.

- Parameters:
- name: (String) The name of the character.
- description: (String) A description of the character.
- iconImage: (Icon) Information about the icon image of the character.
 */
struct CharacterListData {
    let name: String
    let fullDescription: String
    let iconImage: Icon

    var descriptionText: String{
        let seperator = "-"
        if let range = fullDescription.range(of: seperator) {
            let substring = fullDescription[range.upperBound...].trimmingCharacters(in: .whitespaces)
            return substring
        }
        return fullDescription
    }

    static func parseTo(from characterData: CharacterDataModel) -> CharacterListData {
        return CharacterListData(name: getCharacterName(from: characterData.text) ?? "",
                                 fullDescription: characterData.text,
                                 iconImage: characterData.icon)
    }

    func getImage(completion: @escaping (UIImage?) -> Void) {
        let baseUrl = "https://duckduckgo.com"
        guard let url = URL(string: baseUrl + self.iconImage.url) else {
            completion(nil)
            return
        }

        URLSession.shared.dataTask(with: url) { (data, response, error) in
            if let error = error {
                print("Error downloading image: \(error.localizedDescription)")
                completion(UIImage(named: "no_image"))
                return
            }

            guard let data = data, let image = UIImage(data: data) else {
                print("Invalid image data")
                completion(UIImage(named: "no_image"))
                return
            }

            completion(image)
        }.resume()
    }

    private static func getCharacterName(from description: String) -> String? {
        if let separatorRange = description.range(of: " - ") {
            let extractedText = description[description.startIndex..<separatorRange.lowerBound].trimmingCharacters(in: .whitespacesAndNewlines)
            return(extractedText)
        } else {
            return(nil)
        }
    }
}
