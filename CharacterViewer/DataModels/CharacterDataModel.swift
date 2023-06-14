//
//  CharacterDataModel.swift
//  CharacterViewer
//
//  Created by Admin on 6/13/23.
//

import Foundation

/**
 JSON parsing object for the list of characters.

 - Parameter characterListDataModel: [CharacterDataModel] All the characters fetched from JSON response.
 */
struct CharacterListDataModel: Codable {
    let characterListDataModel: [CharacterDataModel]

    enum CodingKeys: String, CodingKey {
        case characterListDataModel = "RelatedTopics"
    }
}

/**
 JSON parsing object for a single character data.

 - Parameters:
 - icon: (Icon) Icon data pulled from JSON file.
 - result: (String) Result data pulled from JSON file.
 - text: (String) Text description of a specific character pulled from JSON file.
 */
struct CharacterDataModel: Codable {
    let icon: Icon
    let result: String
    let text: String

    enum CodingKeys: String, CodingKey {
        case icon = "Icon"
        case result = "Result"
        case text = "Text"
    }
}

/**
 JSON parsing for the Icon data of a character data.
 - Parameters:
 - url: (String) The url of the icon pulled from JSON file.
 - height: The height value of icon pulled from JSON file.
 - width: (String) The width value of icon pulled from JSON file.
 */
struct Icon: Codable {
    let url: String
    let height: String
    let width: String

    enum CodingKeys: String, CodingKey {
        case url = "URL"
        case height = "Height"
        case width = "Width"
    }
}
