
import Foundation

extension String {
    func isValidGTIN() -> Bool {
        return checkGTIN(self)
    }
}

func checkGTIN(_ gtin: String) -> Bool {
    // make sure gtin has a valid length
    let validLengths = [14, 13, 12, 8]
    guard validLengths.contains(gtin.count) else { return false }

    // make sure GTIN string has only integers
    let validChars = Array("0123456789")
    let containsOnlyIntegers = gtin.allSatisfy { (char) -> Bool in
        validChars.contains(char)
    }
    if !containsOnlyIntegers { return false }

    // convert [Char] to [Int]
    var gtinDigitsArray = Array(gtin).compactMap { Int(String($0)) }

    // make sure we get all digits from the string
    guard gtinDigitsArray.count == gtin.count else { return false }

    // at this point `gtin` has been successfully converted to digits
    
    let multipliers = [3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3]

    guard let checkDigit = gtinDigitsArray.popLast() else { return false }

    // iterate over rest of array "back to front"
    gtinDigitsArray = gtinDigitsArray.reversed()

    var checkSum = 0
    for (index, value) in gtinDigitsArray.enumerated() {
        let multiplier = multipliers[index]
        checkSum += multiplier * value
    }
    // need to compare last digit to (checkSum subtracted from next highest muliple of 10)
    let checkSumDigit = 10 - checkSum % 10

    return (checkSumDigit == checkDigit)
}

// testing
func testValidGTINs() {
    let validGTINs = [
        "76308722791248", // valid GTIN-14
        "7630872279124", // valid GTIN-13
        "763087227912", // valid GTIN-12
        "76308727" // valid GTIN-8
    ]
    validGTINs.forEach { gtin in
        assert(checkGTIN(gtin)) // test function
        assert(gtin.isValidGTIN()) // test String extension
    }
}

func testInvalidGTINs() {
    let invalidGTINs = [
        "76308722791247", // GTIN-14 with wrong check key
        "7630872279123", // GTIN-13 with wrong check key
        "763087227911", // GTIN-12 with wrong check key
        "76308726", // GTIN-8 with wrong check key
        "0", // wrong length
        "abcdabcd", // right length, no integers
        "9876543a" // right length, not all integers
    ]
    invalidGTINs.forEach { gtin in
        assert(!checkGTIN(gtin)) // test function
        assert(!gtin.isValidGTIN()) // test String extension
    }
}
