; Exercise 1.8

(define (cube-root x)
	(define (cube-iter first-guess? previous-guess guess)
		(if (good-enough? first-guess? previous-guess guess)
			guess
			(cube-iter #f
					   guess
					   (improve guess))))
	(define (improve guess)
		(/ (+ (/ x
				(square guess))
			  (* 2 guess))
		   3))
	(define (good-enough? first-guess? previous-guess guess)
		(if first-guess?
			#f	; always return false for first guess since we don't have a previous guess for comparison
			(< (abs (- previous-guess guess)) (/ guess 100000))))
	(cube-iter #t 1.0 1.0))