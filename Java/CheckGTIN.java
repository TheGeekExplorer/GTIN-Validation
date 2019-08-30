package com.GTIN;


public class GTIN {
    
    
    /* Check length of barcode for validity via the checkdigit calculation
     * We split the barcode into its constituent digits, offset them into the GTIN
     * calculation tuple (x1, x3, x1, x3, x1, etc, etc), multiply the digits and add
     * them together, then modulo them on 10, and you get the calculated check digit.
     * For more information see GS1 website: https://www.gs1.org/check-digit-calculator
     * @param string gtin
     * @return bool */
    public boolean checkGTIN (String gtin) {
        
        int[] CheckDigitArray = {0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0};
        int[] gtinMaths       = {3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3};
        String[] BarcodeArray = gtin.split("(?!^)");
        int gtinLength = gtin.length();
        int modifier = (17 - (gtinLength - 1));
        int gtinCheckDigit = Integer.parseInt(gtin.substring(gtinLength - 1));
        int tmpCheckDigit = 0;
        int tmpCheckSum = 0;
        int tmpMath = 0;
        int i=0;
        int ii=0;
        
        // Run through and put digits into multiplication table
        for (i=0; i < (gtinLength - 1); i++) {
            CheckDigitArray[modifier + i] = Integer.parseInt(BarcodeArray[i]);  // Add barcode digits to Multiplication Table
        }
        
        // Calculate "Sum" of barcode digits
        for (ii=modifier; ii < 17; ii++) {
            tmpCheckSum += (CheckDigitArray[ii] * gtinMaths[ii]);
        }
        
        // Difference from Rounded-Up-To-Nearest-10 - Fianl Check Digit Calculation
        tmpCheckDigit = (int) ((Math.ceil((float) tmpCheckSum / (float) 10) * 10) - tmpCheckSum);
        
        // Check if last digit is same as calculated check digit
        if (gtinCheckDigit == tmpCheckDigit)
            return true;
        return false;
    }

}

