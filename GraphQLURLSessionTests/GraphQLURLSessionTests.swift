//
//  GraphQLURLSessionTests.swift
//  GraphQLURLSessionTests
//
//  Created by WhyQ on 03/05/24.
//

import XCTest
@testable import GraphQLURLSession

final class GraphQLURLSessionTests: XCTestCase {

    func test_ApiResource_With_EmptyString_Returns_Error(){

        // ARRANGE
        let queryString = ""
        let expectation = self.expectation(description: "EmptyString_Returns_Error")
        // ACT
        APIManager.shared.fetchProduct(queryString: queryString) {
            response in
              // ASSERT
            switch response {
            case .success(_):
                break
            case .failure(let error):
                XCTAssertEqual("The operation couldn’t be completed. (GraphQLURLSession.DataError error 1.)", error.localizedDescription)
                expectation.fulfill()
            }
        }

        waitForExpectations(timeout: 6, handler: nil)

    }
}
