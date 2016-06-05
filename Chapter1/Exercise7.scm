; Exercise 1.7

; For convenience in this discussion, I refer to the method outlined in the example in the book, which compares the recent
; guess to a fixed number, as the "old method". I refer to the method specified in this exercise, which compares the difference
; between the last two guesses to a fraction of the guess itself, as the "new method".

; The old method fails at finding the square roots of small numbers, because of limited precision in the fixed value to which it is
; being compared (0.001 in the book). When we need to find the value of a number of that magnitude or smaller, the error
; of the square root calculation becomes relatively large. For example, suppose we compare values to 0.001. If we want to calculate
; the square root of 100, having an answer that is off by 0.0005 seems reasonable, since that is a very small percentage of the answer (10).
; However, if want to calculate the square root of 0.0009, having an answer that is off by 0.0005 is much more significant.
; On the other side of the spectrum, if the fixed comparison threshold is really small in comparison to the number for which the square
; root is being calculated, the lack of precision results in a convergence to an answer that doesn't satisfy the fixed threshold in the old method
; resulting in an infinite loop.

; By comparing the rate of convergence (by finding the absolute of the difference of the last two guesses) to a fixed fraction of the most recent
; guess, the new method is able to overcome both of the issues outlined above. The fact that it avoids both the relatively large errors associated
; with calculating the square root of extremely small numbers and the precision-induced infinite loops associated with extremely large numbers is
; demonstrated in the tests below.
; The tests compare the differences in the methods for calculating the square root of 0.00000007 and a number on the order of 6e64.
; Note in the context of the test results I refer to "error" as the difference in the square of the calculated square root answer and the number
; being square rooted relative to the number being square rooted. So error = (guess answer - C) / C, where C is the number for which we're trying to
; find the square root.

; Small-number test results
; Old method: error that is many times larger than C (on the order of 10^-15)
; New method: error that is many times less than C (on the order of 10^4)

; Large-number test results
; Old method: infinite loop- no answer
; New method: error that is many time less than C (order of magnitude 10^-11)

(define (new-sqrt x)
	(define (sqrt-iter first-guess? previous-guess guess)
		(if (good-enough? first-guess? previous-guess guess)
			guess
			(sqrt-iter #f
					   guess
					   (improve guess))))
	(define (improve guess)
		(average guess (/ x guess)))
	(define (average x y)
		(/ (+ x y) 2))
	(define (good-enough? first-guess? previous-guess guess)
		(if first-guess?
			#f	; always return false for first guess since we don't have a previous guess for comparison
			(< (abs (- previous-guess guess)) (/ guess 100000))))
	(sqrt-iter #t 1.0 1.0))

; I've instrumented the old method with print statements to monitor the interesting convergence that occurred during the
; large number test. You can comment out the display/newline lines to reduce the spam.
(define (old-sqrt x)
	(define (sqrt-iter guess)
		(cond ((good-enough? guess) guess)
			  (else
				(let ((new-guess (improve guess)))
					;(display (abs (- new-guess guess)))
					;(newline)
					(sqrt-iter new-guess)))))
	(define (improve guess)
		(average guess (/ x guess)))
	(define (average x y)
		(/ (+ x y) 2))
	(define (good-enough? guess)
		(< (abs (- (square guess) x)) 0.001))
	(sqrt-iter 1.0))

(define (small-number-test)
	(define c 0.00000007)
	(define new-answer (new-sqrt c))
	(define new-error (abs (- (square new-answer) c)))
	(display (/ new-error c))
	(newline)
	(define old-answer (old-sqrt c))
	(define old-error (abs (- (square old-answer) c)))
	(display (/ old-error c))
	(newline))
	
(define (large-number-test)
	(define c 698234987019871234908213400982309823094820394820980129380983240798.8723498756998329018023)
	(define new-answer (new-sqrt c))
	(define new-error (abs (- (square new-answer) c)))
	(display (/ new-error c))
	(define old-answer (old-sqrt c))
	(display (abs (- (square old-answer) c))))