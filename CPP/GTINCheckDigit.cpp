#include <iostream>
#include <string>

using namespace std;


/**
 * Define the operations class
 */
class GTINCheckDigit {
    
    // Define variables
    string barcode;
    
    // Define classes
    public:
        GTINCheckDigit (string inBarcode);
        bool check ();
        bool checkBasics ();
};


// Constructor method
GTINCheckDigit::GTINCheckDigit (string inBarcode) {
    barcode = inBarcode;
}


// Check barcode is valid
bool GTINCheckDigit::check () {
    
    bool state = false;
    
    // Check basics
    state = this->checkBasics();
    
    // Check check digit
    // TODO
    
    return state;
}


// Run basic checks on provided barcode string
bool GTINCheckDigit::checkBasics () {
    // Check length is ok
    if (barcode.length() < 8 or barcode.length() > 14)
        return false;
    
    // Check whether is a number
    //preg_match("/\d+/", $gtin, $m, PREG_OFFSET_CAPTURE, 0);
    //if (empty($m))
    //    return false;
    
    // Is valid, return true
    return true;
}
