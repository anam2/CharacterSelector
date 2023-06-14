//
//  SimpsonsTests.swift
//  SimpsonsTests
//
//  Created by Admin on 6/13/23.
//

import XCTest

final class SimpsonsTests: XCTestCase {

    func testSimpsonURLIsNotNil() {
        let url = URL(string: "http://api.duckduckgo.com/?q=simpsons+characters&format=json")!
        URLSession.shared.dataTask(with: url) { (data, response, error) in
            XCTAssertNotNil(data, "Data should not be nil.")
        }
    }

}
