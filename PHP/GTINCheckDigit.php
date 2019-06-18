<?php namespace gtin;

class GTIN {

    /* Check length of barcode for validity via the checkdigit calculation
     * We split the barcode into it's constituent digits, offset them into the GTIN
     * calculation tuple (x1, x3, x1, x3, x1, etc, etc), multiply the digits and add
     * them together, then modulo them on 10, and you get the calculated check digit.
     * For more information see GS1 website: https://www.gs1.org/check-digit-calculator
     * @param string gtin
     * @return bool */
    public static function CheckGTIN (string $gtin) : bool {
    
        # Check that GTIN provided is a certain length
        if (!CheckBasics($gtin))
            return false;
        
        # Define fixed variables
        $CheckDigitArray = [];
        $gtinMaths = [3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3];
        $modifier = 17 - (strlen($gtin) - 1);  // Gets the position to place first digit in array
        $gtinCheckDigit = substr($gtin, -1); // Get provided check digit
        $BarcodeArray = str_split($gtin);  // Split barcode at each digit into array
        $gtinLength = strlen($gtin);
        $tmpCheckDigit = 0;
        $tmpCheckSum = 0;
        $tmpMath = 0;
        
        # Run through and put digits into multiplication table
        for ($i=0; $i < ($gtinLength - 1); $i++) {
            $CheckDigitArray[$modifier + $i] = $BarcodeArray[$i];  // Add barcode digits to Multiplication Table
        }
        
        # Calculate "Sum" of barcode digits
        for ($i=$modifier; $i < 17; $i++) {
            $tmpCheckSum += ($CheckDigitArray[$i] * $gtinMaths[$i]);
        }
        
        # Difference from Rounded-Up-To-Nearest-10 - Fianl Check Digit Calculation
        $tmpCheckDigit = (int)(ceil($tmpCheckSum / 10) * 10) - $tmpCheckSum;
        
        # Check if last digit is same as calculated check digit
        if ($gtinCheckDigit == $tmpCheckDigit)
            return true;
        return false;
    }
    
    /* Checks the length of the GTIN
     * @param string gtin
     * @return bool */
    public static function CheckBasics (string $gtin) : bool {
        # Check length is ok
        if (strlen($gtin) < 8 || strlen($gtin) > 14)
            return false;
        
        # Check whether is a number
        preg_match("/\d+/", $gtin, $m, PREG_OFFSET_CAPTURE, 0);
        if (empty($m))
            return false;
        
        # Is valid, return true
        return true;
    }
}

