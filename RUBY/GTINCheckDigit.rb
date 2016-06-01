
class GTIN
    
    def self.check_gtin (gtin)
        
        # GTIN math preparations
        barcode_array = gtin.split('')                                       # Split GTIN into array
        gtin_maths = [3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3]     # Modifers for the GTIN calculation
        modifier = (16 - gtin.length)                                        # Find the offset for modifer tuple start
        gtin_check_digit = gtin[-1, 1]                                       # Get the check digit provided
        gtin_length = gtin.length                                            # GTIN provided's length
        
        # Temporary variables
        check_digit_array = {}
        tmp_check_digit = 0
        tmp_check_sum = ""
        tmp_math = 0
        
        # Run through and put digits into multiplication table
        for i in 0..(gtin_length - 2)
            check_digit_array[modifier.to_i + i.to_i] = barcode_array[i.to_i];  # Add barcode digits to Multiplication Table
        end
        
        # Calculate "Sum" of barcode digits
        for i in modifier..17
            tmp_check_sum = (tmp_check_sum.to_i + (check_digit_array[i].to_i * gtin_maths[i].to_i)) # Do math on consituents
        end
                
        # Difference from Rounded-Up-To-Nearest-10 - Fianl Check Digit Calculation
        tmp_check_digit = (((tmp_check_sum.to_f / 10).ceil * 10).to_f - tmp_check_sum.to_f).to_i
        
        # Check if last digit is same as calculated check digit
        if gtin_check_digit.to_i == tmp_check_digit.to_i
            return true
        else
            return false
        end
    end
end


# Run function! 
puts GTIN.check_gtin ('502037900587')
