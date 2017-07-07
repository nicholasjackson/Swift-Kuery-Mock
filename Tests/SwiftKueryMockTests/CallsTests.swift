import Foundation
import XCTest

@testable import SwiftKueryMock

public class CallsTests: XCTestCase {
    public func testOnCallIfCallbackRegisteredCallbackCalled() {
        var callback = false
        var args: [Any]?
        let calls = Calls()

        calls.on(method:"testMethod") {arguments in
            callback = true
            args = arguments
        }

        calls.called(method: "testMethod", arguments: [Any](){true})

        XCTAssertTrue(callback, "Callback should have been called")
        XCTAssertNotNil(args, "Args should have been returned")
    }

    public func testOnCallNoCallbackRegisteredCallbackNotCalled() {
        var callback = false
        var args: [Any]?
        let calls = Calls()

        calls.on(method:"notCalledMethod") {arguments in
            callback = true
            args = arguments
        }

        calls.called(method: "testMethod", arguments: [Any](){true})

        XCTAssertFalse(callback, "Callback should not have been called")
        XCTAssertNil(args, "Args should have be nil returned")
    }
}
