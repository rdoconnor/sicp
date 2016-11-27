; Exercise 1.25
; 
; This will end terribly for testing primality with the Fermat test, because we will be large numbers
; as exponents. We don't have a data type that will hold a^1019 for any a > 1, for example. This will result
; in multiplication overflow and unreliable calculations. Instead, the calculation used in 1.24 calculates with
; remainders as the process recurses, so we never deal with a number greater than the target number we're testing
; for primality (so 1019 instead of a^1019).

(define (expmod base exp m)
	(remainder (fast-expt base exp) m))