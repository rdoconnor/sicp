; Exercise 2.40
; Unique-pairs procedure

; Part I:
; Given an integer n, generate the sequence of pairs (i,j)
; such that 1 <= j < i <= n

(define (unique-pairs n)
	(flatmap (lambda (i)
				(map (lambda (j) (list i j))
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
		
(define (unit-tests)
	(part1-unit-tests)
	(part2-unit-tests))
	
(define (part1-unit-tests)
	(define (test-answer n ans)
		(assert (equal? (unique-pairs n) ans)))
	(test-answer 1 '())
	(test-answer 2 (list (list 2 1)))
	(test-answer 4 (list (list 2 1) (list 3 1) (list 3 2) (list 4 1) (list 4 2) (list 4 3)))
	(display "part1 tests completed successfully")
	(newline))
		
; Part II:
; Use unique-pairs to simplify the definition of prime-sum-pairs
(define (old-prime-sum-pairs n)
	(map make-pair-sum
		 (filter prime-sum?
				 (flatmap
					(lambda (i)
						(map (lambda (j) (list i j))
							 (enumerate-interval 1 (- i 1))))
					(enumerate-interval 1 n)))))
					
(define (new-prime-sum-pairs n)
	(map make-pair-sum
		 (filter prime-sum?
				(unique-pairs n))))
				
					
(define (prime-sum? pair)
	(prime? (+ (car pair) (cadr pair))))
	
(define (make-pair-sum pair)
	(list (car pair) (cadr pair) (+ (car pair) (cadr pair))))
	
(define (filter predicate sequence)
	(cond ((null? sequence) '())
		  ((predicate (car sequence))
			(cons (car sequence)
				  (filter predicate (cdr sequence))))
		  (else (filter predicate (cdr sequence)))))

(define (prime? n)
	(define (iter i)
		(cond ((> (square i) n) #t)
			  ((= (remainder n i) 0) #f)
			  (else (iter (+ i 1)))))
	(iter 2))
	
(define (part2-unit-tests)
	(define (test-answer n)
		(assert (equal? (old-prime-sum-pairs n) (new-prime-sum-pairs n))))
	(test-answer 6)
	(display "part2 tests completed successfully")
	(newline))