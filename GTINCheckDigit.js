// Check length of barcode for validity
function CheckDigit (gtin) {
    var CheckDigitArray = [];
    var gtinMaths = [3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3];
    var modifier = 17 - (gtin.length - 1); // Gets the position to place first digit in array
    var gtinCheckDigit = gtin.slice(-1);   // Get provided check digit
    var BarcodeArray = gtin.split("");     // Split barcode at each digit into array
    var gtinLength = gtin.length;
    var tmpCheckDigit = 0;
    var tmpCheckSum = 0;
    var tmpMath = 0;
    
    // Run through and put digits into multiplication table
    for (i=0; i < (gtinLength - 1); i++) {
        CheckDigitArray[modifier + i] = BarcodeArray[i];  // Add barcode digits to Multiplication Table
    }
    
    // Calculate "Sum" of barcode digits
    for (i=modifier; i < 17; i++) {
        tmpCheckSum += (CheckDigitArray[i] * gtinMaths[i]);
    }
        
    // Difference from Rounded-Up-To-Nearest-10 - Fianl Check Digit Calculation
    tmpCheckDigit = (Math.ceil(tmpCheckSum / 10) * 10) - parseInt(tmpCheckSum);
    
    // Check if last digit is same as calculated check digit
    if (gtin.slice(-1) == tmpCheckDigit)
        return true;
}
