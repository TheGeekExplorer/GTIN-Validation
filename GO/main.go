package main

import (
    "fmt"
    "regexp"
    //"math"
)

func main() {
    result := CheckGTIN("5012345264581")
    fmt.Println(result)
}

func CheckGTIN (gtin string) bool {
    
    // Check length and is a number
    if !CheckBasics(gtin) {
        return false
    }
    
    // Define variables
    var gtinMaths map[int]int = map[int]int{ 0: 1, 1: 3, 2: 1, 3: 3, 4: 1, 5: 3, 6: 1, 7: 3, 8: 1, 9: 3, 10: 1, 11: 3, 12: 1, 13: 3, 14: 1, 15: 3, 16: 1, 17: 3, }
    var CheckDigitArray []int = make([]int, 17, 17)  // Array of calculations
    var modifier int = (17 - (len(gtin) - 1))        // Modifier for Calc Table
    var gtinCheckDigit string = gtin[len(gtin)-1:]   // Get supplied Check Digit
    var gtinLength int = len(gtin)                   // Length of GTIN
    
    // Split string at chars into an array
    var BarcodeArray []int = make([]int, 17, 17)
    for i, r := range gtin { BarcodeArray[i] = int(r) }
    
    // Temp Variables
    var tmpCheckDigit int = 0
    var tmpCheckSum int = 0
    var tmpMath int = 0
    
    // Run through and put digits into multiplication table
    for i := 0; i < (gtinLength - 1); i++ {
        CheckDigitArray[modifier + i] = BarcodeArray[i]  // Add barcode digits to Multiplication Table
    }
    
    // Calculate "Sum" of barcode digits
    for i := modifier; i < 17; i++ {
        tmpCheckSum = tmpCheckSum + (CheckDigitArray[i] * gtinMaths[i])
    }
    
    // TODO: Difference from Rounded-Up-To-Nearest-10 - Fianl Check Digit Calculation
}


func CheckBasics (gtin string) bool {
    
    // If length wrong
    if len(gtin) < 8 || len(gtin) > 14 {
        return false
    }
    
    // If not a number
    match, _ := regexp.MatchString("[0-9]+", gtin)
    if !match {
        return false
    }
    return true
}
