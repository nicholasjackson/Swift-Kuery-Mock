import Foundation
import XCTest

@testable import SwiftKueryMock

public class CallsTests: XCTestCase {
    public func testOnCallIfCallbackRegisteredCallbackCalled() {
        var callback = false
        let calls = Calls()

        calls.on(method:"testMethod") {_ in
            callback = true
        }

        calls.called(method: "testMethod", arguments: nil)

        XCTAssertTrue(callback, "Callback should have been called")
    }

    public func testOnCallIfCallbackRegisteredWithSpecificArgumentsCallbackCalled() {
        var callback = false
        var shouldNotBeCalled = true
        var args: [Any]?
        let calls = Calls()

        calls.on(method:"testMethod") {_ in
            shouldNotBeCalled = false
        }

        calls.on(method:"testMethod", withArguments: ["true"]) {arguments in
            callback = true
            args = arguments
        }

        calls.called(method: "testMethod", arguments: ["true"])

        XCTAssertTrue(shouldNotBeCalled, "Callback with no arguments should not have been called")
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

        calls.called(method: "testMethod", arguments: ["true"])

        XCTAssertFalse(callback, "Callback should not have been called")
        XCTAssertNil(args, "Args should have be nil returned")
    }
}
