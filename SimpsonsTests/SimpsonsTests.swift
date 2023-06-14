//
//  SimpsonsTests.swift
//  SimpsonsTests
//
//  Created by Admin on 6/13/23.
//

import XCTest

final class SimpsonsTests: XCTestCase {
    let character1 = CharacterListData(name: "Character1",
                                       fullDescription: "Character1 - This is a sample description",
                                       iconImage: Icon(url: "", height: "", width: ""))

    override func setUp() {
        super.setUp()
    }

    func testSimpsonURLIsNotNil() {
        let url = URL(string: "http://api.duckduckgo.com/?q=simpsons+characters&format=json")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            XCTAssertNotNil(data, "Data should not be nil.")
        }
    }

    func testDescriptionTextToMakeSureCharacterNameIsNotIncluded() {
        XCTAssertEqual(character1.descriptionText, "This is a sample description")
    }

}
