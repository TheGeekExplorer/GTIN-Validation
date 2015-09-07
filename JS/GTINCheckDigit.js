// Check length of barcode for validity
function CheckGTIN (gtin) {

    // Check length of barcode for validity
    if (!CheckBasics(gtin))
        return false;

    // Define fixed variables 
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

// Checks the validity of the input - is it
// the right length (8, 12, 13, 14), and is
// a numeric value
function CheckBasics (gtin) {
    // Check length is ok
    if (gtin.length != 8 && gtin.length != 12 && gtin.length != 13 && gtin.length != 14)
        return false;
    
    // Check whether is a number
    var m = gtin.match(/\d+/);
    if (isNaN(m[0]))
        return false;
    
    // Is valid, return true
    return true;
}
