; Exercise 1.36
; More fixed-point analysis

(define tolerance 0.00001)

(define (fixed-point f first-guess)
	(let ((output-file (open-output-file "test.txt")))
		(define (close-enough? v1 v2)
			(< (abs (- v1 v2)) tolerance))
		(define (try guess)
			(let ((next (f guess)))
				(display guess output-file)
				(newline output-file)
				(if (close-enough? guess next)
					next
					(try next))))
		(set! output-file (open-output-file "test2.txt"))
		(try first-guess)
		(close-port output-file)))
		
; Without damping - 29 steps from an initial value of 4.0
; With damping - 7 steps from an initial value of 4.0


; Without damping details:
; Call: (fixed-point (lambda (x) (/ (log 1000) (log x))) 4.0)
; Steps:
; 4.
; 4.9828921423310435
; 4.301189432497896
; 4.734933901055578
; 4.442378437719526
; 4.632377941509958
; 4.505830646780212
; 4.588735606875766
; 4.533824356566501
; 4.56993352418142
; 4.546075272637246
; 4.561789745175654
; 4.55141783665413
; 4.5582542120702625
; 4.553744140202578
; 4.556717747893265
; 4.554756404545319
; 4.5560497413912975
; 4.5551967522618035
; 4.555759257615811
; 4.555388284933278
; 4.555632929754932
; 4.555471588998784
; 4.555577989320218
; 4.555507819903776
; 4.555554095154945
; 4.555523577416557
; 4.555543703263474
; 4.555530430629037
;
; Without damping details:
; Call: (fixed-point (lambda (x) (/ (+ x (/ (log 1000) (log x))) 2)) 4.0)
; Steps:
; 4.
; 4.491446071165521
; 4.544974650975552
; 4.553746974742814
; 4.555231425802502
; 4.555483906560562
; 4.5555268862194875
