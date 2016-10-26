; Exercise 1.14
; Understanding time and space complexity of counting change

; Complexities for counting change
; n is the amount of change (input to count-change)
; Time: THETA(n^5)
; Space: THETA(n)
;
; More generally:
; For input n and coins d1, d2, d3, ..., dk
; Time: THETA(n^k)
; Space: THETA(n / d1) = THETA(n)
;

; The following was instrumented to measure time complexity

(define output-file (open-output-file "ChangeGrowth.csv"))
(define cc-count 0)

(define (count-change amount)
	(set! cc-count 0)
	(cc amount 2))
	
(define (cc amount kinds-of-coins)
	(set! cc-count (+ cc-count 1))
	(cond ((= amount 0) 1)
		  ((or (< amount 0) (= kinds-of-coins 0)) 0)
		  (else (+ (cc amount
						(- kinds-of-coins 1))
				   (cc (- amount
							(first-denomination kinds-of-coins))
						kinds-of-coins)))))
						
(define (first-denomination kinds-of-coins)
	(cond ((= kinds-of-coins 1) 1)
		  ((= kinds-of-coins 2) 5)
		  ((= kinds-of-coins 3) 10)
		  ((= kinds-of-coins 4) 25)
		  ((= kinds-of-coins 5) 50)))
		  
(define (print-n-results n)
	(define (iter i)
		(cond ((< i n)
				(display i output-file)
				(display "," output-file)
				(count-change i)
				(display cc-count output-file)
				(newline output-file)
				(iter (+ i 1)))
			  (else (flush-output output-file))))
	(iter 0))