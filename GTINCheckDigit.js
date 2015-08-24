// Check length of barcode for validity
function CheckDigit (gtin) {
    var CheckDigitArray = [];
    var gtinMaths = [3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3];
    var modifier = 17 - (gtinLength - 1); // Gets the position to place first digit in array
    var gtinCheckDigit = gtin.slice(-1);  // Get provided check digit
    var BarcodeArray = gtin.split("");    // Split barcode at each digit into array
    var gtinLength = gtin.length;
    var tmpCheckDigit = 0;
    var tmpCheckSum = 0;
    var tmpMath = 0;
    
    // Run through and put chars into array
    for (i=0; i < (gtinLength - 1); i++) {
        CheckDigitArray[modifier + i] = BarcodeArray[i];  // Add barcode digits to Multiplication Table
    }
    
    // Calculate "Sum"
    for (i=modifier; i < 17; i++) {
        tmpMath = CheckDigitArray[i] * gtinMaths[i];
        tmpCheckSum += tmpMath;
    }
        
    // Difference from nearest 10 - Fianl Check Digit Calculation
    if (tmpCheckSum < (Math.round(tmpCheckSum / 10) * 10)) {
        tmpCheckDigit = (Math.round(tmpCheckSum / 10) * 10) - parseInt(tmpCheckSum);
    } else {
        tmpCheckDigit = parseInt(tmpCheckSum) - (Math.round(tmpCheckSum / 10) * 10);
    }
    
    // Check if last digit is same as calculated check digit
    if (gtin.slice(-1) == tmpCheckDigit)
        return true;
        
    // else return false
    return false;
}
