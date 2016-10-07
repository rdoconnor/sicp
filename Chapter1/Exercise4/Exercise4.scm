; Exercise 1.4

(define (a-plus-abs-b a b)
	((if (> b 0) + -) a b))
	
; This returns the value of a + abs(b) since the operator is based on the sign of b.
; The cases break down in the following ways:
; If b is positive, we calculate a + b.
; If b is negative, we calculate a - b.
; If b is zero, we calculate a - b, but since b is zero, the difference is a.
; These are the same exact cases as if we used the abs procedure.