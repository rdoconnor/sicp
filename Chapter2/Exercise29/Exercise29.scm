; Exercise 2.29
; Binary mobile data structure

; Short answer (for part d)
; If we needed to change the underlying representation to be based on cons instead of list, the
; only thing we would need to change (besides, obviously the two constructors) would be changing
; the selectors for right-branch and branch-structure to be (cdr) instead of (car (cdr))

; Constructors for mobile and branch are given
(define (make-mobile left right)
	;(cons left right))
	(list left right))
	
(define (left-branch mobile)
	(car mobile))
	
(define (right-branch mobile)
	;(cdr mobile))
	(car (cdr mobile)))
	
(define (make-branch length structure)
	;(cons length structure))
	(list length structure))
	
(define (branch-length branch)
	(car branch))
	
(define (branch-structure branch)
	;(cdr branch))
	(car (cdr branch)))
	
(define (weight-branch branch)
	(let ((structure (branch-structure branch)))
		(cond ((pair? structure) (total-weight structure))
			  (else structure))))
	
(define (total-weight mobile)
	(+ (weight-branch (left-branch mobile))
	   (weight-branch (right-branch mobile))))

(define (balanced? mobile)
	(define (balanced-structure? structure)
		(cond ((pair? structure) (balanced? structure))
			  (else #t)))
	(let ((left (left-branch mobile))
		  (right (right-branch mobile)))
		(let ((torque-left (* (branch-length left) (weight-branch left)))
			  (torque-right (* (branch-length right) (weight-branch right))))
			(and (= torque-left torque-right)
				(balanced-structure? (branch-structure left))
				(balanced-structure? (branch-structure right))))))
	
(define (unit-tests)
	(let ((branch1 (make-branch 3 5))
		  (branch2 (make-branch 5 4)))
		(let ((mobile1 (make-mobile branch1 branch2))
			 (mobile3 (make-mobile branch1 branch1)))
			(let ((branch3 (make-branch 10 mobile1)))
				(let ((mobile2 (make-mobile branch3 branch3)))
					(assert (equal? (left-branch mobile1) branch1))
					(assert (equal? (right-branch mobile1) branch2))
					(assert (equal? (branch-length branch1) 3))
					(assert (equal? (branch-structure branch1) 5))
					(assert (equal? (branch-structure branch3) mobile1))
					(assert (equal? (total-weight mobile1) 9))
					(assert (equal? (total-weight mobile2) 18))
					(assert (equal? (balanced? mobile1) #f))
					(assert (equal? (balanced? mobile2) #f))
					(assert (equal? (balanced? mobile3) #t))))))
	(display "tests completed successfully"))