; Exercise 1.31
; Creating and using a product procedure
;
; (1) Create a product procedure analogous to sum
; (2) Use it to create a factorial procedure
; (3) Use it to approximate pi
; (4) Create an iterative or recursive procedure, whichever wasn't made in (1)

(define (prodcut-recursive term a next b)
	(if (> a b)
		1
		(* (term a)
		   (prodcut-recursive term (next a) next b))))
		   
(define (product-iterative term a next b)
	(define (iter a result)
		(if (> a b)
			result
			(iter (next a) (* result (term a)))))
	(iter a 1))

(define product product-iterative)
		   
(define (factorial n)
	(define (identity x) x)
	(define (increment x) (+ x 1))
	(product identity 1 increment n))
	
; n is for rough indication of precision
(define (appx-pi n)
	(define (num-term x) (- (+ x 2) (remainder x 2)))
	(define (den-term x) (+ x 1 (remainder x 2)))
	(define (increment x) (+ x 1))
	(* 4.0 (/ (product num-term 1 increment n)
		   (product den-term 1 increment n))))