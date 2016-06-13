; Exercise 1.12
; Pascal's triangle

(define (CalculatePascalValueByPosition column row)
	(define (iter c r)
		(if (or (= c 1) (= c r))
			1
			(+ (iter c (- r 1))
			   (iter (- c 1) (- r 1)))))
	(cond ((< column 0) (error "Column value must be positive"))
		  ((< row 0) (error "Row value must be positive"))
		  ((> column row) (error "Column value cannot be greater than row value"))
		  (else (iter column row))))

; Generates unformatted triangle
(define (GenerateTriangle rows)
	(define (row-iter r)
		(define (column-iter c)
			(cond ((<= c r)
					(display (CalculatePascalValueByPosition c r))
					(display " ")
					(column-iter (+ c 1)))
				  (else
					(newline))))
		(cond ((<= r rows)
				(column-iter 1)
				(row-iter (+ r 1)))))
	(if (< rows 1)
		(error "Rows must be positive")
		(row-iter 1)))
		
; Example output
; (GenerateTriangle 10)
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