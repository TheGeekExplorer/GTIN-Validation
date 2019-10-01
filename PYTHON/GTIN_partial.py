
def GTIN(gtin):
    checkDigitArray = [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0]
    gtinMaths       = [3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3]
    BarcodeArray    = gtin.split()
    gtinLength      = len(gtin)
    modifier        = (17 - (gtinLength - 1))
    gtinCheckDigit  = gtin[gtinLength-1]
    tmpCheckDigit   = 0;
    tmpCheckSum     = 0;
    tmpMath         = 0;
    i               = 0;
    ii              = 0;
    
       

print(GTIN("50334434344"))

