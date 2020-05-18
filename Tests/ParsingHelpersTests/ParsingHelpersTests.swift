import XCTest
@testable import ParsingHelpers

final class ParsingHelpersTests: XCTestCase {
    var input: String! = nil {
        didSet {
            remainder = input.map { $0[...] }
        }
    }
    
    var remainder: Substring!
    
    override func tearDown() {
        remainder = nil
        input = nil
    }
    
    func testRemoveWhile() {
        input = "hello world"
        let str = remainder.remove(while: { $0.isLetter })
        XCTAssert(str == "hello")
        XCTAssert(String(remainder) == " world")
    }
    
    func testRemoveNonExistentWhile() {
        input = "hello world"
        let str = remainder.remove(while: { $0.isDecimalDigit })
        XCTAssert(str == "")
        XCTAssert(String(remainder) == input)
    }
    
    func testPrefix() {
        input = "hello world"
        XCTAssert(remainder.remove(prefix: "hello"))
        XCTAssertEqual(String(remainder), " world")
    }
    
    func testNonExistentPrefix() {
        input = "hello world"
        XCTAssertFalse(remainder.remove(prefix: "hello!"))
        XCTAssertEqual(String(remainder), input)
    }
}
