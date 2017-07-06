import XCTest
@testable import Swift_Kuery_Mock

class Swift_Kuery_MockTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Swift_Kuery_Mock().text, "Hello, World!")
    }


    static var allTests = [
        ("testExample", testExample),
    ]
}
