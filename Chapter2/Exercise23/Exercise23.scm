; Exercise 2.23
; Implementing for-each

(define (for-each proc items)
	(define (iter remaining-items)
		(cond ((not (null? remaining-items))
				(proc (car remaining-items))
				(iter (cdr remaining-items)))))
	(iter items))
	
; Manual test result
; (for-each (lambda (x) (newline) (display x))
;			(list 57 321 88))
; displays:
; 57
; 321
; 88