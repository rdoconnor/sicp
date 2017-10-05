; Exercise 1.12
; Pascal's triangle

(define (print-triangle n)
	(define (recursively-print row col)
		; print number
		(display (find-value row col))
		; new-line if end of row
		(cond ((= row col) (newline))
			  (else (display " ")))
		; what's next?
		(cond ((and (= row col) (< row (- n 1)))
				(recursively-print (+ row 1) 0))
			  ((< col row)
				(recursively-print row (+ col 1)))))
	(define (find-value row col)
		(cond ((or (= col 0) (= col row)) 1)
			  (else (+ (find-value (- row 1) (- col 1))
					   (find-value (- row 1) col)))))
	(recursively-print 0 0))
		
; Example output																										
; (print-triangle 10)
; 1
; 1 1
; 1 2 1
; 1 3 3 1
; 1 4 6 4 1
; 1 5 10 10 5 1
; 1 6 15 20 15 6 1
; 1 7 21 35 35 21 7 1
; 1 8 28 56 70 56 28 8 1
; 1 9 36 84 126 126 84 36 9 1