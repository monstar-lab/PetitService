import XCTest
@testable import PetitService

final class PetitServiceTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(PetitService().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
