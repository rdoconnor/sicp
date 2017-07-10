; Exercise 2.41
; Find all ordered triples of distinct positive integers i,j,k
; such that 1 <= k < j < i <= n and i+j+k = s

(define (unique-triple-sums n s)
	(filter (lambda (triple) (= (+ (car triple) (cadr triple) (caddr triple)) s))
			(unique-triples n)))

(define (unique-triples n)
	(flatmap (lambda (i)
				(flatmap (lambda (j)
						(map (lambda (k) (list i j k))
							 (enumerate-interval 1 (- j 1))))
					 (enumerate-interval 1 (- i 1))))
			 (enumerate-interval 1 n)))
			 
; Flatmap provided in section 2.2.3
(define (flatmap proc seq)
	(accumulate append '() (map proc seq)))
	
; Accumulate procedure provided in section 2.2.1
(define (accumulate op initial sequence)
	(if (null? sequence)
		initial
		(op (car sequence)
			(accumulate op initial (cdr sequence)))))
			
; Enumerate-interval provided in 2.2.3
(define (enumerate-interval low high)
	(if (> low high)
		'()
		(cons low (enumerate-interval (+ low 1) high))))
		
(define (filter predicate sequence)
	(cond ((null? sequence) '())
		  ((predicate (car sequence))
			(cons (car sequence)
				  (filter predicate (cdr sequence))))
		  (else (filter predicate (cdr sequence)))))
		  
(define (unit-tests)
	(define (test-answer n sum ans)
		(assert (equal? (unique-triple-sums n sum) ans)))
	(test-answer 3 6 (list (list 3 2 1)))
	(test-answer 3 5 '())
	(display "tests completed successfully"))