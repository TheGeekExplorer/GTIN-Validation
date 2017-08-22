''' validateBarcode
''' Validates the CheckDigit on the provided GTIN Barcode; if it
''' is the same as the calculated check digit then the barcode is
''' valid, and the method will return a TRUE, else FALSE.
''' @param string gtin
''' @return boolean
Public Function validateBarcode(ByVal gtin)
    
    ''' Error handling '''
    If CStr(gtin) = "" Or Len(CStr(gtin)) > 17 Then
        GoTo ENDING
    End If
    
    ''' SHOW IN DEBUG VALIDATION BEGINNING '''
    Debug.Print "VALIDATING BARCODE CHECK DIGIT..."
    
    ''' Define the variables '''
    Dim checkDigitArray(1 To 17) As Integer
    Dim gtinMaths(1 To 17) As Integer
    Dim modifier As Integer
    Dim gtinCheckDigitTMP(1 To 17) As Integer
    Dim gtinCheckDigit As Integer
    Dim gtinLength As Integer
    Dim BarcodeArray() As String
    ReDim BarcodeArray(1 To 17) As String
    Dim tmpCheckDigit As Integer: tmpCheckDigit = 0
    Dim tmpCheckSum As Integer: tmpCheckSum = 0
    Dim tmpMath As Integer: tmpMath = 0
    Dim i As Integer: i = 1
    
    ''' Build the gtinMaths object '''
    gtinMaths(1) = 3
    gtinMaths(2) = 1
    gtinMaths(3) = 3
    gtinMaths(4) = 1
    gtinMaths(5) = 3
    gtinMaths(6) = 1
    gtinMaths(7) = 3
    gtinMaths(8) = 1
    gtinMaths(9) = 3
    gtinMaths(10) = 1
    gtinMaths(11) = 3
    gtinMaths(12) = 1
    gtinMaths(13) = 3
    gtinMaths(14) = 1
    gtinMaths(15) = 3
    gtinMaths(16) = 1
    gtinMaths(17) = 3
    
    ''' The modifier '''
    modifier = 18 - Len(CStr(gtin))
    
    ''' Split the barcode into digits in an array '''
    BarcodeArray = splitStringIntoCharArray(gtin)
    
    ''' Get the last digit (Check Digit) '''
    gtinCheckDigit = BarcodeArray(Len(gtin))
    
    ''' Get gtinLength '''
    gtinLength = Len(gtin)
        
    ''' Run through the barcode chars, and assign them to the modifier array '''
    ''' e.g. [----5020379004332] or [--------502888344]                      '''
    Dim tmpOut As String
    tmpOut = "--> MODIFIER ARRAY: ["
    
    Do While i < (modifier + 1)
        tmpOut = tmpOut + "-"
        i = Val(i) + 1
    Loop
    i = 1
    
    ''' Run through GTIN and put into offset array, so it's aligned on the '''
    ''' right hand side of the array limits (e.g. [-----50203790001]       '''
    Do While i < (Val(gtinLength))
        checkDigitArray(Val(modifier) + Val(i)) = Val(BarcodeArray(Val(i))) '  // Add barcode digits to Multiplication Table
        tmpOut = tmpOut + BarcodeArray(Val(i))
        i = Val(i) + 1
    Loop
    tmpOut = tmpOut + "]"
    Debug.Print tmpOut
    i = 1
    
    
    ''' Calculate the CheckSum of the combined digits in the barcode using '''
    ''' the gtinMaths array to multiply digits (1, 3, 1, 3, 1, 3 etc)      '''
    i = modifier
    Do While i < 18
        tmpCheckSum = Val(tmpCheckSum) + (checkDigitArray(i) * gtinMaths(i))
        i = Val(i) + 1
    Loop
    
    
    ''' Round up to nearest 10, then take away the CheckSum to get the '''
    ''' calculated CheckDigit for provided barcode/gtin                '''
    tmpCheckDigit = (Round((tmpCheckSum / 10) + 0.5) * 10) - tmpCheckSum
    
    
    ''' PRINT OUT VARIABLES TO DEBUG '''
    Debug.Print "--> Checksum: " + CStr(tmpCheckSum)
    Debug.Print "--> Check Digit: " + CStr(gtinCheckDigit)
    Debug.Print "--> Calculated Digit: " + CStr(tmpCheckDigit)
    
    
    ''' Check if the calculated CheckDigit matches the CheckDigit in the Barcode '''
    If gtinCheckDigit = tmpCheckDigit Then
    Debug.Print "--> !!! VALID !!!"
        validateBarcode = True
    Else
        Debug.Print "--> !!! INVALID !!!"
        validateBarcode = False
    End If
    
    
ENDING:
End Function


''' splitStringIntoCharArray
''' Takes a barcode, and splits it into single chars, and returns them in an array
''' @param string Barcode
''' @return array BarcodeArray
Private Function splitStringIntoCharArray(ByVal Barcode)

    Dim BarcodeArray(1 To 17) As String
    Dim digitID As Integer: digitID = 0
    
    ' Loop through chars and store in array
    Do While digitID < (Len(CStr(Barcode)))
        BarcodeArray(Val(digitID) + 1) = Left(Right(Barcode, (Len(Barcode) - digitID)), 1)
        digitID = Val(digitID) + 1
    Loop
    
    ' Return array of chars
    splitStringIntoCharArray = BarcodeArray
End Function
