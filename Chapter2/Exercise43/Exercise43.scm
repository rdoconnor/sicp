; Exercise 2.43
; Louis's slow eight-queens program

; Louis's program is really slow. For each recursive call to the queens-cols procedure (for say k)
; the recursive call to queens-cols for k-1 is made b times where b is the size of the board
; In the normal procedure, the recursive call for k-1 is only called once

; I estimate that the run time of the normal queen's procedure is THETA(n^3) where n is the size of the board / number of queens
; Louis's is THETA(n^n)

(define empty-board '())

; from Exercise 2.42
(define (proper-queens board-size)
	(define (queens-cols k)
		(if (= k 0)
			(list empty-board)
			(filter
				(lambda (positions) (safe? k positions))
				(flatmap
					(lambda (rest-of-queens)
						(map (lambda (new-row)
								(adjoin-position new-row k rest-of-queens))
							 (enumerate-interval 1 board-size)))
					(queens-cols (- k 1))))))
	(queens-cols board-size))
	
(define (louis-queens board-size)
	(define (queens-cols k)
		(if (= k 0)
			(list empty-board)
			(filter
				(lambda (positions) (safe? k positions))
				(flatmap
					(lambda (new-row)
						(map (lambda (rest-of-queens)
								(adjoin-position new-row k rest-of-queens))
							 (queens-cols (- k 1))))
					(enumerate-interval 1 board-size)))))
	(queens-cols board-size))
	
(define (safe? k board)
	(let ((k-row (cadar (filter (lambda (pos) (= (car pos) k)) board))))
		; gather all queens that would put the k-th queen in check
		; if the list is empty, then no other queens can put it in check and this k position is safe
		(null? (filter (lambda (pos) (invalid-position pos k k-row))
					(filter (lambda (pos) (not (= (car pos) k)))
							board)))))
							
(define (invalid-position pair k-col k-row)
	(let ((col (car pair))
		  (row (cadr pair)))
		(assert (not (= col k-col))) ; this better not happen
		(cond ((= row k-row) #t)  ; horizontally in check
			  ((= (- k-col col) (abs (- k-row row))) #t)  ; diagonal check
			  (else #f))))
							 
(define (adjoin-position new-row column existing-board)
	(append existing-board (list (list column new-row))))
							 
; Enumerate-interval provided in 2.2.3
(define (enumerate-interval low high)
	(if (> low high)
		'()
		(cons low (enumerate-interval (+ low 1) high))))
		
; Flatmap provided in section 2.2.3
(define (flatmap proc seq)
	(accumulate append '() (map proc seq)))
	
; Accumulate procedure provided in section 2.2.1
(define (accumulate op initial sequence)
	(if (null? sequence)
		initial
		(op (car sequence)
			(accumulate op initial (cdr sequence)))))
			
(define (filter predicate sequence)
	(cond ((null? sequence) '())
		  ((predicate (car sequence))
			(cons (car sequence)
				  (filter predicate (cdr sequence))))
		  (else (filter predicate (cdr sequence)))))
	
(define (perf-costs x)
	(define (perf-normal-test n)
		(let ((start-time (system-clock)))
			(proper-queens n)
			(- (system-clock) start-time)))
	(define (perf-louis-test n)
		(let ((start-time (system-clock)))
			(louis-queens n)
			(- (system-clock) start-time)))
	(define (perf-comparison n)
		(display "For ")
		(display n)
		(display " queens, the time cost is:")
		(newline)
		(display "Normal: ")
		(display (perf-normal-test n))
		(newline)
		(display "Louis: ")
		(display (perf-louis-test n))
		(newline))
	(perf-comparison x))
	 
; verify I copied the problem from the book correctly	
(define (unit-tests)
	(define (test-full-answer n ans)
		(assert (equal? (louis-queens n) ans)))
	; I really don't want to write out full answers for n > 4
	(define (test-answer-count n ans)
		(assert (= (length (louis-queens n)) ans)))
	(test-full-answer 1 (list (list (list 1 1))))
	(test-full-answer 2 '())
	(test-full-answer 3 '())
	;(test-full-answer 4 (list (list (list 1 2) (list 2 4) (list 3 1) (list 4 3)) (list (list 1 3) (list 2 1) (list 3 4) (list 4 2))))
	(test-answer-count 5 10)
	(test-answer-count 8 92)	; answers for 5,8 from wikipedia
	(display "tests completed successfully"))