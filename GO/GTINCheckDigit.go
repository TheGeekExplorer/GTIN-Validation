// TOOD : Work in Progress

package main

import (
	"fmt"
)

/* Main Function Init Point */
func main() {

	// Define the GTIN
	var gtin string = "5020379453454"

	// Build the XML output
	resp := CheckGTIN(gtin)

	// Output XML
	fmt.Println(resp)
}


/* Builds the XML Feed for the USERS TABLE */
func CheckGTIN(gtin string) bool {
    	
    // Check length of barcode for validity
    if (!CheckGTIN(gtin)) { return false }
    
    // Define fixed variables 
    var CheckDigitArray []int
    var gtinMaths []int = make([]int, 17, 17); 
    var modifier int = 17 - (len(gtin) - 1)          // Gets the position to place first digit in array
    var gtinCheckDigit string = gtin[len(gtin)-1:1]  // Get last digit of GTIN (Check Digit)
    var BarcodeArray []int = make([]int, 17, 17)     // Split barcode at each digit into array
    var gtinLength int = len(gtin)
    var tmpCheckDigit int = 0
    var tmpCheckSum int = 0
    var tmpMath int = 0
    	
    return true
}
