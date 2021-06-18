import XCTest

import SwiftConcurrencyTests

var tests = [XCTestCaseEntry]()
tests += SwiftConcurrencyTests.allTests()
XCTMain(tests)
