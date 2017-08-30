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
    debug.print "+ VALIDATING BARCODE CHECK DIGIT..."
    
    ''' Define the variables '''
    Dim checkDigitArray(1 To 17) As Integer
    Dim gtinMaths() As String
    ReDim gtinMaths(1 To 17) As String
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
    gtinMaths = splitStringIntoCharArray("31313131313131313")
    
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
        checkDigitArray(CInt(modifier) + CInt(i)) = CInt(BarcodeArray(Val(i))) '  // Add barcode digits to Multiplication Table
        tmpOut = tmpOut + BarcodeArray(CInt(i))
        i = Val(i) + 1
    Loop
    debug.print tmpOut + "]"
    i = 1
    
    
    ''' Calculate the CheckSum of the combined digits in the barcode using '''
    ''' the gtinMaths array to multiply digits (1, 3, 1, 3, 1, 3 etc)      '''
    i = modifier
    Do While i < 18
        tmpCheckSum = CInt(tmpCheckSum) + (CInt(checkDigitArray(i)) * CInt(gtinMaths(i)))
        i = Val(i) + 1
    Loop
    
    
    ''' Round up to nearest 10, then take away the CheckSum to get the '''
    ''' calculated CheckDigit for provided barcode/gtin                '''
    tmpCheckDigit = CInt(Round((tmpCheckSum / 10) + 0.5) * 10) - CInt(tmpCheckSum)
    
    
    ''' PRINT OUT VARIABLES TO DEBUG '''
    debug.print  "--> Checksum: " + CStr(tmpCheckSum)
    debug.print  "--> Check Digit: " + CStr(gtinCheckDigit)
    debug.print  "--> Calculated Digit: " + CStr(tmpCheckDigit)
    
    
    ''' Check if the calculated CheckDigit matches the CheckDigit in the Barcode '''
    If CInt(gtinCheckDigit) = CInt(tmpCheckDigit) Then
        debug.print  "--> !!! VALID !!!"
        validateBarcode = True
    Else
        debug.print  "--> !!! INVALID !!!"
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
