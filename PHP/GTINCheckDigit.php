<?php

namespace gtin;

// Check length of barcode for validity
public function CheckDigit ($gtin) {
    $CheckDigitArray = [];
    $gtinMaths[3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3];
    $modifier = 17 - strlen($gtin - 1);  // Gets the position to place first digit in array
    $gtinCheckDigit = substr($gtin, -1);  // Get provided check digit
    $BarcodeArray = explode($gtin, "");  // Split barcode at each digit into array
    $gtinLength = strlen($gtin);
    $tmpCheckDigit = 0;
    $tmpCheckSum = 0;
    $tmpMath = 0;
    
    // Run through and put digits into multiplication table
    for ($i=0; $i < ($gtinLength - 1); $i++) {
        $CheckDigitArray[$modifier + $i] = $BarcodeArray[$i];  // Add barcode digits to Multiplication Table
    }
    
    // Calculate "Sum" of barcode digits
    for ($i=$modifier; $i < 17; $i++) {
        $tmpCheckSum += ($CheckDigitArray[$i] * $gtinMaths[$i]);
    }
        
    // Difference from Rounded-Up-To-Nearest-10 - Fianl Check Digit Calculation
    $tmpCheckDigit = (ceil($tmpCheckSum / 10) * 10) - int($tmpCheckSum);
    
    // Check if last digit is same as calculated check digit
    if ($gtinCheckDigit == $tmpCheckDigit)
        return true;
}
