
class GTIN
    
	def self.check_gtin (gtin)
		
		# GTIN math preparations
		@barcode_array = gtin.split('')                                      # Split GTIN into array
		@gtin_maths = [3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3, 1, 3]    # Modifers for the GTIN calculation
		modifier = (17 - gtin.length)                                        # Find the offset for modifer tuple start
		gtin_check_digit = gtin[-1, 1]                                       # Get the check digit provided
		gtin_length = gtin.length                                            # GTIN provided's length
		
		# Temporary variables
		tmpCheckDigit = 0
        tmpCheckSum = 0
        tmpMath = 0
		
		# TODO
		
		return true
	end
	
end


# Run function! 
puts GTIN.check_gtin ('50203790052')
