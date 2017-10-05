; Exercise 1.6
; Understanding why the implementation of "if" must be a special form and can't be an ordinary procedure.

(define (new-if predicate then-clause else-clause)
	(cond (predicate then-clause)
		  (else else-clause)))
		  
(define (sqrt-iter guess x)
	(new-if (good-enough? guess x)
			guess
			(sqrt-iter (improve guess x)
						x)))
						
(define (improve guess x)
	(average guess (/ x guess)))
	
(define (average x y)
	(/ (+ x y) 2))
	
(define (good-enough? guess x)
	(< (abs (- (square guess) x)) 0.001))
	
; The result of using new-if is indefinite recursion that results in the max recursion depth being reached.
; This is because when new-if is called with the arguments of (good-enough? guess x), guess, and (sqrt-iter (improve guess x) x), all three
; of these are evaluated on each call to new-if with applicative order evaluation. Since the call to sqrt-iter is recursive and will result 
; in this new-if (and thus sqrt-iter) being called again, this results in unterminated recursion.
; With the regular if (which is a special form), there is a terminating condition for the recursion, because the call to sqrt-iter is only made if the
; call to good-enough? returns false. Given that Newton's method tends to converge towards an answer that is eventually "good enough",
; we expect good-enough? to eventually return true, meaning that the recursion terminates and returns an answer without making more calls
; to sqrt-iter (which would happen with new-if).