; Exercise 2.16
; Generalized solution for an improved interval arithmetic package

; Based on the results of exercises 2.14 and 2.15, error bounds grow arbitrarily
; large with repeated use of the same variable in an interval arithmetic equation.
; In order to fix this, the use of the interval arithmetic package should create
; equations that minimize or eliminate repeated use of the same variable.
;
; This problem was labelled in the text as "very difficult"- I don't think I'd be able
; to create an interval arithmetic package that generally solves this problem.
; It doesn't "seem" possible since it would need to eliminate all repeated uses of the same
; variable, but I don't know how to prove that (yet).