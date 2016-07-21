#include <iostream>
#include <string>
#include "GTINCheckDigit.cpp"

using namespace std;


/**
 * Run the main method
 */
int main (int argc, char* argv[]) {
    
    // Read in the values from the CLI
    string barcode = argv[1];
    
    // Instantiate GTIN Class
    GTINCheckDigit GTIN (barcode);
    
    // Check GTIN Validity!
    if (GTIN.check())
        cout << "OK";
    else
        cout << "NOT_OK";
}
