//
//  TheWireTests.swift
//  TheWireTests
//
//  Created by Admin on 6/13/23.
//

import XCTest

final class TheWireTests: XCTestCase {

    func testTheWireURLIsNotNil() {
        let url = URL(string: "http://api.duckduckgo.com/?q=the+wire+characters&format=json")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            XCTAssertNotNil(data, "Data should not be nil.")
        }
    }

}
