''' validateBarcode
''' Validates the CheckDigit on the provided GTIN Barcode; if it is the same as
''' the calculated check digit then the barcode is valid, and returns TRUE/FALSE.
''' @param string gtin
''' @return boolean
Public Function validateBarcode(ByVal gtin)
    If CStr(gtin) = "" Or Len(CStr(gtin)) > 17 Then
        GoTo ENDING
    End If
    
    ''' SHOW IN DEBUG VALIDATION BEGINNING '''
    CoreUtils.WriteToLog "+ VALIDATING BARCODE CHECK DIGIT..."
    
    ''' Define the variables '''
    Dim gtinMaths() As String: ReDim gtinMaths(1 To 17) As String
    Dim checkDigitArray(1 To 17), gtinCheckDigitTMP(1 To 17), gtinCheckDigit, gtinLength, tmpCheckDigit, tmpCheckSum, tmpMath, modifier, i As Integer
    Dim BarcodeArray() As String: ReDim BarcodeArray(1 To 17) As String
    Dim tmpOut As String
    tmpCheckDigit = 0: tmpCheckSum = 0: tmpMath = 0: i = 1
    
    ''' Build the gtinMaths object '''
    gtinMaths = splitStringIntoCharArray("31313131313131313")
    
    ''' The modifier '''
    modifier = 18 - Len(CStr(gtin))
    
    ''' Split the barcode into digits in an array '''
    BarcodeArray = splitStringIntoCharArray(gtin)
    
    ''' Get the last digit (Check Digit) '''
    gtinCheckDigit = BarcodeArray(Len(gtin))
    
    ''' Run through the barcode chars, and assign them to the modifier array '''
    ''' e.g. [----5020379004332] or [--------502888344]                      '''
    tmpOut = "--> MODIFIER ARRAY: ["
    Do While i < (modifier + 1): tmpOut = tmpOut + "-": i = Val(i) + 1: Loop: i = 1
    
        ''' Run through GTIN and put into offset array, so it's aligned on the '''
        ''' right hand side of the array limits (e.g. [-----50203790001]       '''
        Do While i < (Val(Len(CStr(gtin))))
            checkDigitArray(CInt(modifier) + CInt(i)) = CInt(BarcodeArray(Val(i))) '  // Add barcode digits to Multiplication Table
            tmpOut = tmpOut + BarcodeArray(CInt(i)): i = Val(i) + 1
        Loop:
    
    ''' End debug array string
    CoreUtils.WriteToLog tmpOut + "]": i = 1
    
    ''' Calculate the CheckSum of the combined digits in the barcode using '''
    ''' the gtinMaths array to multiply digits (1, 3, 1, 3, 1, 3 etc)      '''
    tmpCheckSum = calculateCheckSum(checkDigitArray, gtinMaths, modifier)
    
    ''' Round up to nearest 10, then take away the CheckSum to get the '''
    ''' calculated CheckDigit for provided barcode/gtin                '''
    tmpCheckDigit = CInt(Round((tmpCheckSum / 10) + 0.5) * 10) - CInt(tmpCheckSum)
    
    ''' PRINT OUT VARIABLES TO DEBUG '''
    CoreUtils.WriteToLog "--> Checksum: " + CStr(tmpCheckSum)
    CoreUtils.WriteToLog "--> Check Digit: " + CStr(gtinCheckDigit)
    CoreUtils.WriteToLog "--> Calculated Digit: " + CStr(tmpCheckDigit)
    
    ''' Check if the calculated CheckDigit matches the CheckDigit in the Barcode '''
    If CInt(gtinCheckDigit) = CInt(tmpCheckDigit) Then
        CoreUtils.WriteToLog "--> !!! VALID !!!"
        validateBarcode = True
    Else
        CoreUtils.WriteToLog "--> !!! INVALID !!!"
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
    splitStringIntoCharArray = BarcodeArray
End Function

''' calculateCheckSum
''' Takes all of the digits in the array and calculated the CheckSum
''' @param array checkDigitArray
''' @param array gtinMaths
''' @param integer modifier
''' @return integer checksum
Private Function calculateCheckSum(ByVal checkDigitArray, ByVal gtinMaths, ByVal modifier)
    Dim tmpCheckSum As Integer: tmpCheckSum = 0
    Dim i As Integer: i = modifier
    
    ' Do calculation
    Do While i < 18
        tmpCheckSum = CInt(tmpCheckSum) + (CInt(checkDigitArray(i)) * CInt(gtinMaths(i)))
        i = Val(i) + 1
    Loop
    calculateCheckSum = tmpCheckSum
End Function
