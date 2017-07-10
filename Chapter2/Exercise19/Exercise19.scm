; Exercise 2.19
; Making the change-counting program from 1.2.2 more general

; Given the procedure definition for cc, define:
; first-denomination, except-first-denomination, and no-more?

(define us-coins (list 50 25 10 5 1))
(define reverse-us-coins (list 1 5 10 25 50))

(define uk-coins (list 100 50 20 10 5 2 1 0.5))

(define (cc amount coin-values)
	(cond ((= amount 0) 1)
		  ((or (< amount 0) (no-more? coin-values)) 0)
		  (else
			(+ (cc amount
				   (except-first-denomination coin-values))
			   (cc (- amount
					  (first-denomination coin-values))
				   coin-values)))))
				   
(define (first-denomination coin-values)
	(car coin-values))
	
(define (except-first-denomination coin-values)
	(cdr coin-values))
	
(define (no-more? coin-values)
	(null? coin-values))
	
; Also to answer the question "does order of the coins matter?"
; No.

(define (unit-tests)
	(define (test-answer amount coins solution)
		(assert (equal? (cc amount coins) solution)))
	(test-answer 100 us-coins 292)	; example in book
	(test-answer 100 reverse-us-coins 292)
	(test-answer 0 uk-coins 1)	; there is one way to have 0
	(test-answer 1 us-coins 1)
	(test-answer 0.5 uk-coins 1)
	(display "tests completed successfully"))